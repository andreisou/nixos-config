{
	description = "anddsz's NixOS configuration collection";

	outputs = inputs: {
		templates = {
			daily = {
				description = "My daily driver configuration";
				path = ./daily;
			};
		};
	};
}
