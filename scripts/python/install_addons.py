from dataclasses import dataclass
import os
import pathlib
import shutil
import stat
import subprocess
from typing import Callable, Any

import copier
from rich import print
from rich.prompt import Confirm


@dataclass(frozen=True)
class Git:
    repo: str
    subdirectory: str
    vcs_ref: str | None = None


CI = os.getenv("CI_CD")
PROJECT_DIR = pathlib.Path(os.path.dirname(__file__)).parent.parent.absolute()
CACHE = f"{PROJECT_DIR}/.addons/copier"
ADDONS = f"{PROJECT_DIR}/addons"


DEPENDENCIES = {
    "deformablemesh": Git(
        repo="gh:cloudofoz/godot-deformablemesh",
        subdirectory="addons/deformablemesh",
    ),
    "gevp": Git(
        repo="gh:DAShoe1/Godot-Easy-Vehicle-Physics",
        subdirectory="addons/gevp",
    ),
    "keychain": Git(
        repo="gh:Orama-Interactive/Keychain",
        subdirectory="addons/keychain",
    ),
    "quick_layout_changer": Git(
        repo="gh:mathrick/godot-quick-layout-changer",
        subdirectory="addons/quick_layout_changer",
    ),
    "resources_spreadsheet_view": Git(
        repo="gh:don-tnowe/godot-resources-as-sheets-plugin",
        subdirectory="addons/resources_spreadsheet_view",
        vcs_ref="Godot-4",
    ),
    "shaderV": Git(
        repo="gh:arkology/ShaderV",
        subdirectory="addons/shaderV",
    ),
    "SphynxMotionBlurToolkit": Git(
        repo="gh:sphynx-owner/JFA_driven_motion_blur_addon",
        subdirectory="addons/SphynxMotionBlurToolkit",
        vcs_ref="4.5",
    ),
    "traudio": Git(
        repo="gh:RodZill4/TRAudio",
        subdirectory="addons/traudio",
    ),
    "zylann.hterrain": Git(
        repo="gh:Zylann/godot_heightmap_plugin",
        subdirectory="addons/zylann.hterrain",
    ),
}


def on_rmtree_exc(func: Callable[..., Any], path: str, _: Any):
    """
    Error handler for ``shutil.rmtree``.

    If the error is due to an access error (read only file)
    it attempts to add write permission and then retries.

    If the error is for another reason it re-raises the error.

    Usage : ``shutil.rmtree(path, onerror=onerror)``
    """
    # Is the error an access error?
    if not os.access(path, os.W_OK):
        os.chmod(path, stat.S_IWUSR)
        func(path)
    else:
        raise


addons_exists = False
if pathlib.Path(ADDONS).exists():
    with os.scandir(ADDONS) as directory:
        if any(directory):
            addons_exists = True

if (
    not CI
    and addons_exists
    and Confirm.ask("Addons folder already exists. Delete for proper installation?")
):
    shutil.rmtree(
        ADDONS,
        onexc=on_rmtree_exc,
    )

if not CI:
    subprocess.run(
        ["dotnet", "godotenv", "addons", "install"],
        # stderr=subprocess.DEVNULL,
    )
else:
    print("")


for name, git in DEPENDENCIES.items():
    normalize = os.path.normpath

    dependency = normalize(f"{CACHE}/{name}")
    addon = normalize(f"{dependency}/{git.subdirectory}")
    target = normalize(f"{PROJECT_DIR}/addons/{name}")

    if not pathlib.Path(dependency).exists() or Confirm.ask(
        f"Update dependency {name}?"
    ):
        copier.run_copy(git.repo, dependency, vcs_ref=git.vcs_ref)

    try:
        if os.name == "nt":
            subprocess.run(
                ["mklink", "/j", target, addon], shell=True, capture_output=True
            )
        elif CI:
            shutil.copy(addon, target)
        else:
            os.symlink(addon, target)

    except PermissionError:
        if pathlib.Path(target).exists():
            shutil.rmtree(target)
        shutil.copytree(addon, target)
