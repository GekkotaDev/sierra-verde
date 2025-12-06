using Godot;
using System.Linq;

[GlobalClass]
public partial class DialogStory : Resource {
	[Export]
	public bool Persist = true;

	[Export]
	public string Id { get; set; }

	[Export]
	public Godot.Collections.Dictionary<string, Variant> Facts { get; set; }

	public int Hash {
		get {
			var sorted = new Godot.Collections.Dictionary();
			foreach (var name in Facts.Keys.OrderBy(key => key)) {
				sorted[name] = Facts[name];
			}

			return sorted.GetHashCode();
		}
	}

	public DialogStory() {
		Id = "";
		Facts = (dynamic)new Godot.Collections.Dictionary();
	}
}
