//Shader again:

// == ALPHA TEST TRANSPARENCY (aka cutoff, cutout)

// To make a thing transparent:
// Make sure you use have these 2 tags:
Tags {
	"Queue" = "AlphaTest" 
	"RenderType" = "TransparentCutout"
	}

// In frag shader add:
clip(col.a - 0.5); // this 0.5 is the cutoff value, you can put it in a variable or property

// == ALPHA BLEND TRANSPARENCY
