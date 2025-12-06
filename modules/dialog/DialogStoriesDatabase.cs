using Godot;
using System;

public partial class DialogStoriesDatabase : Node {
	[Export]
	public Godot.Collections.Dictionary<string, DialogStory> Stories { get; set; }

	public DialogStoriesDatabase Add(DialogStory story) {
		Stories[story.Id] = story;
		return this;
	}

	public DialogStoriesDatabase Remove(string id) {
		Stories[id] = null;
		return this;
	}
}
