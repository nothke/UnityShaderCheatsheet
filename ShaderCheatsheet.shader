

███████╗██╗  ██╗ █████╗ ██████╗ ███████╗██████╗     ██╗  ██╗███████╗██╗     ██████╗ ██╗
██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗    ██║  ██║██╔════╝██║     ██╔══██╗██║
███████╗███████║███████║██║  ██║█████╗  ██████╔╝    ███████║█████╗  ██║     ██████╔╝██║
╚════██║██╔══██║██╔══██║██║  ██║██╔══╝  ██╔══██╗    ██╔══██║██╔══╝  ██║     ██╔═══╝ ╚═╝
███████║██║  ██║██║  ██║██████╔╝███████╗██║  ██║    ██║  ██║███████╗███████╗██║     ██╗
╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝

// - Or - I will never learn how to write shaders by heart
// by Nothke, contact: nothke@gmail.com or https://twitter.com/Nothke

// All comments are written preceeding with // so that shader highlighting can be used in a text editor (like sublime)

// All categories mentioned in comments for searching are written in caps, for example "see MY TITLE"
// To navigate to a category, like MY TITLE find it with hashtag like "#MY TITLE"

// This cheatsheet primarily focuses on VERTEX/FRAMGENT shaders and not on SURFACE shaders,
// but some of the surface shader things are mentioned in a separate category on the bottom. see SURFACE

// #STRUCTURE

// #VERT/FRAG shader

Shader "Custom/Name"
{
	Properties // See PROPERTIES
	{
		
	}

	Tags // See TAGS
	Blend // See BLEND MODES

	Pass
	{
		CGPROGRAM

		#include // See INCLUDES

		#pragma vertex vert // See PRAGMAS
		#pragma fragment frag

		// custom variables

		struct appdata { }; // not necessary if using one of predefined ones, see #APPDATA

		struct v2f { }; // see #STRUCTS
	
		v2f vert (appdata v) { };
	
		fixed4 frag (v2f i) : SV_Target { };
	
		ENDCG
	}

	Pass // Another pass...
	{

	}
}



// #PROPERTIES

Properties
{
	// Syntax: _VariableName ("Label in the inspector", Type) = default value
	_RangedFloat ("Ranged Float", Range (min, max)) = number
	_Float ("Float", Float) = number
	_Int ("Int", Int) = number
	_Color ("Some Color", Color) = (1,1,1,1)
	_Vector ("Some Vector", Vector) = (0,0,0,0)
	_Texture ("Texture", 2D) = "white" {} // "", “white” (1,1,1,1), “black” (0,0,0,0), “gray” (0.5,0.5,0.5,0.5), “bump” (0.5,0.5,1,0.5) or “red” (1,0,0,0)
	_Cubemap ("Cubemap", CUBE) = "" {}
	_3DTexture ("3DTexture", 3D) = "defaulttexture" {}

	// Standard properties:
	// Unity's builtin shaders use _MainTex ss the main diffuse/albedo slot,
	// so it is advised to use this 
	_MainTex ("Main Tex", 2D) = "white" {}
	_BumpMap ("Bumpmap", 2D) = "bump" {}

	// Attiributes:
	[HideInInspector]
	[NoScaleOffset] // no texture tiling/offset fields in inspector
	[Normal] // expects a normal map and adds a "Fix Now" button to convert
	[HDR] // expects an HDR
	[Gamma] // indicates that a float/vector property is specified as sRGB value in the UI (just like colors are), and possibly needs conversion according to color space used
	[PerRendererData] // indicates that a texture property will be coming from per-renderer data in the form of a MaterialPropertyBlock. Material inspector changes the texture slot UI for these properties.

	// Sliders
	[PowerSlider(3.0)] _Shininess ("Shininess", Range (0.01, 1)) = 0.08 // A slider with "power of" (in this case ^3) response curve
	[IntRange] _Alpha ("Alpha", Range (0, 255)) = 100 // integer slider for specified range (0 to 255)

	// Decorators
	[Space(50)] _Prop2 ("Prop2", Float) = 0 // creates space before property
	[Header(A group of things)] _Prop1 ("Prop1", Float) = 0 // creates a header before property

	[Enum(UnityEngine.Rendering.BlendMode)] _Blend ("Blend mode", Float) = 1 // blend mode popup menu
	[Enum(One,1,SrcAlpha,5)] _Blend2 ("Blend mode subset", Float) = 1 // a subset of blend mode values, just "One" (value 1) and "SrcAlpha" (value 5)

	// multi_compile Shader Keywords
	[Toggle(THINGY)] _Fancy ("Thingy", Float) = 0 // toggles a THINGY multi_compile shader keyword, see #MULTI_COMPILE
	[KeywordEnum(None, Add, Multiply)] _Overlay ("Overlay mode", Float) = 0
}

// They would be accessed in HSLS code as:
half _Float;
fixed _Float;
float _Float;

int _Int;
uint _Int;

// half, fixed, float + 2,3,4 are all possible combinations for example:
fixed4 _Color; // low precision type is usually enough for colors
float4 _Vector;

float4x4 _Matrix;

sampler2D _Texture;
samplerCUBE _Cubemap;
sampler3D _3DTexture;

// Tiling and Offset information can be obtain by [TEXTURE NAME]_ST, that needs to be defined separately
float4 _Texture_ST; // (x = x tiling, y = y tiling, z = x offset, w = y offset)

// Texture size can be obtained through the Vector4 [TEXTURE NAME]_TexelSize
float4 _Texture_TexelSize; // x = 1.0/width, y = 1.0/height, z = width, w = height

// Never personally used, see in official docs
float4 _Texture_HDR

// #TAGS

Tags { 
	"Queue" = "Background" | "Geometry" | "AlphaTest" | "Transparent" | "Overlay"
	// special cases with +number, e.g. "Geometry+1"
	"RenderType" = "Transparent" | "TransparentCutout" | "Background" | "Overlay"
					| "TreeOpaque" | "TreeTransparentCutout" | "TreeBillboard" | "Grass" | "GrassBillboard"
	"IgnoreProjector" = "True" 
	"DisableBatching" = "True" | "False" | "LODFading"
	"ForceNoShadowCasting" = "True"
	"IgnoreProjector" = "True"
	"CanUseSpriteAtlas" = "False" // if the shader is meant for sprites, and will not work when they are packed into atlases
	"PreviewType" = "Sphere" | "Plane" | "Skybox" // how should the inspector preview the material, Plane is 2D
}

// incomplete

// #BLEND MODES

Blend Off

Blend SrcAlpha OneMinusSrcAlpha // Traditional transparency
Blend One OneMinusSrcAlpha // Premultiplied transparency
Blend One One // Additive
Blend OneMinusDstColor One // Soft Additive
Blend DstColor Zero // Multiplicative
Blend DstColor SrcColor // 2x Multiplicative

BlendOp colorOp // provide a custom operation
BlendOp colorOp, alphaOp
AlphaToMask On | Off // aka Alpha to coverage, allows MSAA to be used on pixels of an alpha test shader

// #Culling & Z

Cull Back | Front | Off
ZWrite On | Off
ZTest Less | Greater | LEqual | GEqual | Equal | NotEqual | Always
Offset Factor, Units
Name "PassName" // Name a pass so that it can be reused by calling UsePass from other shaders
ColorMask RGB | A | 0 | any combination of R, G, B, A // used to select which channel to use with blending

// #PRAGMAS ==

// Pragmas are compilation directives
// They written inside the CGPROGRAM ENDCG block
#pragma vertex name // function that acts on every mesh vertex
#pragma fragment name // function that acts on every visible pixel
#pragma geometry name // DX10 geometry shader function. Acts per triangle. Turns on #pragma target 4.0
// Used for tessellation:
#pragma hull name // DX11 hull shader function. Acts once per patch. Turns on #pragma target 5.0
#pragma domain name // DX11 domain shader function. Turns on #pragma target 5.0

// #VERTEX STRUCTS

// built-in shortcut appdatas:
appdata_base // position, normal and one texture coordinate.
appdata_tan // position, tangent, normal and one texture coordinate.
appdata_full // position, tangent, normal, four texture coordinates and color.
appdata_img // vertex shader input with position and one texture coordinate.

// or custom struct like:
struct appdata {
	// built in types:
    float4 vertex : POSITION;
    float3 normal : NORMAL;
    float4 tangent : TANGENT;
    fixed4 color : COLOR;

    float4 texcoord : TEXCOORD0; // or some people write "uv"
	float3 mycustomthing : TEXCOORD1; // for other custom things use TEXCOORD-number
};

// this is what appdata_full has:
struct appdata_full {
    float4 vertex : POSITION;
    float4 tangent : TANGENT;
    float3 normal : NORMAL;
    float4 texcoord : TEXCOORD0;
    float4 texcoord1 : TEXCOORD1;
    fixed4 color : COLOR;
#if defined(SHADER_API_XBOX360)
    half4 texcoord2 : TEXCOORD2;
    half4 texcoord3 : TEXCOORD3;
    half4 texcoord4 : TEXCOORD4;
    half4 texcoord5 : TEXCOORD5;
#endif
};

// #STRUCTS
// #VERTEX TO FRAGMENT STRUCT

// COLOR0, COLOR2.. etc is used for low precision 0-1 values
// TEXCOORD0, TEXCOORD1.. etc is used for high precision
// ^ this only matters on older, dx9 hardware

// Note: COLOR is the same as COLOR0, the same goes for TEXCOORD and TEXCOORD0 (TODO: check if true)

struct v2f {
    float4 pos : SV_POSITION;
    fixed4 color : COLOR; // this didn't neeed to be COLOR (see above)

    float4 uv : TEXCOORD0;
    float3 normal : TEXCOORD1;

    uint vid : SV_VertexID // vertex ID, needs to be uint, requires #pragma target 3.5
}; // NOTE THE SEMICOLON HERE AFTER STRUCT!

// #VERTEX SHADER

// If you only need position, you can return just a float4 in clip space
float4 vert (float4 vertex : POSITION) : SV_POSITION
{
    return UnityObjectToClipPos(vertex);
}

// if you have more data, you need to return a custom structure (see VERTEX TO FRAGMENT STRUCT)

// The values output from the vertex shader will be interpolated across the face of the rendered triangles,
// and the values at each pixel will be passed as inputs to the fragment shader.

v2f vert (appdata_base v)
{
    v2f o;
    o.pos = UnityObjectToClipPos(v.vertex); // clip pos, NOT object position
    // uv
    o.uv = float4( v.texcoord.xy, 0, 0 );
    // vertex color
    o.color = v.color;

    // VIEW (camera) - camera view
    o.viewDir = normalize(WorldSpaceViewDir(v.vertex));
    return o;
} // NO SEMICOLON AFTER FUNCTIONS!

o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
vs
o.vertex = UnityObjectToClipPos(v.vertex);
?



// #FRAGMENT SHADER

// usually, you would use : SV_Target semantic, like:
fixed4 frag (v2f i) : SV_Target
{
	return i.color // to visualize vertex color for eg.
}

// ---------

// but you can also return custom structure if you need additional colors (as in multiple render targets):
struct fragOutput
{
	fixed4 color : SV_Target;
	fixed4 color2 : SV_Target0; // for additional render targets .. add as many SV_TargetN as you need
	fixed4 depth : SV_Depth; // overrides the z buffer value. Note on some GPUs it turns off depth buffer optimizations
};

fragOutput frag (v2f i)
{
	fragOutput o;
	o.color = fixed4(i.uv, 0, 0);
	o.color2 = i.color;
	o.depth = 0;
	return o;
}

// ---------

// You can use VPOS to obtain screen space vertex position in pixels
// requires #pragma target 3.0
fixed4 frag (v2f i, UNITY_VPOS_TYPE screenPos : VPOS) : SV_Target
{
	return fixed4(screenPos.xy, 0, 0); // X Y is in pixels!
}

// You can use VFACE to obtain face facing
// VFACE input positive for frontbaces,negative for backfaces
// requires #pragma target 3.0
fixed4 frag (fixed facing : VFACE) : SV_Target
{
    return facing > 0 ? _ColorFront : _ColorBack;
}

// ---------

// #BUILT-IN FUNCTIONS

// #INCLUDES

#include HLSLSupport.cginc // (automatically included) Helper macros and definitions for cross-platform shader compilation.
#include UnityShaderVariables.cginc // (automatically included) Commonly used global variables.

#include UnityCG.cginc // commonly used helper functions.
#include AutoLight.cginc // lighting & shadowing functionality, e.g. surface shaders use this file internally.
#include Lighting.cginc // standard surface shader lighting models; automatically included when you’re writing surface shaders.
#include TerrainEngine.cginc // helper functions for Terrain & Vegetation shaders.

// Vertex transformation functions in UnityCG.cginc
float4 UnityObjectToClipPos(float3 pos)	// Transforms a point from object space to the camera’s clip space in homogeneous coordinates. This is the equivalent of mul(UNITY_MATRIX_MVP, float4(pos, 1.0)), and should be used in its place.
float3 UnityObjectToViewPos(float3 pos)	// Transforms a point from object space to view space. This is the equivalent of mul(UNITY_MATRIX_MV, float4(pos, 1.0)).xyz, and should be used in its place.

// Generic helper functions in UnityCG.cginc
float3 WorldSpaceViewDir (float4 v)	// Returns world space direction (not normalized) from given object space vertex position towards the camera.
float3 ObjSpaceViewDir (float4 v)	// Returns object space direction (not normalized) from given object space vertex position towards the camera.
float2 ParallaxOffset (half h, half height, half3 viewDir)	// calculates UV offset for parallax normal mapping.
fixed Luminance (fixed3 c)	// Converts color to luminance (grayscale).
fixed3 DecodeLightmap (fixed4 color)	// Decodes color from Unity lightmap (RGBM or dLDR depending on platform).
float4 EncodeFloatRGBA (float v)	// Encodes [0..1) range float into RGBA color, for storage in low precision render target.
float DecodeFloatRGBA (float4 enc)	// Decodes RGBA color into a float.
float2 EncodeFloatRG (float v)	// Encodes [0..1) range float into a float2.
float DecodeFloatRG (float2 enc)	// Decodes a previously-encoded RG float.
float2 EncodeViewNormalStereo (float3 n)	// Encodes view space normal into two numbers in 0..1 range.
float3 DecodeViewNormalStereo (float4 enc4)	// Decodes view space normal from enc4.xy.

// Only in forward rendering
float3 WorldSpaceLightDir (float4 v)	//Computes world space direction (not normalized) to light, given object space vertex position.
float3 ObjSpaceLightDir (float4 v)	//Computes object space direction (not normalized) to light, given object space vertex position.
float3 Shade4PointLights (...)	//Computes illumination from four point lights, with light data tightly packed into vectors. Forward rendering uses this to compute per-vertex lighting

// Screen-space helper functions in UnityCG.cginc
float4 ComputeScreenPos (float4 clipPos)	// Computes texture coordinate for doing a screenspace-mapped texture sample. Input is clip space position. The function takes care of platform differences in render texture coordinates.
float4 ComputeGrabScreenPos (float4 clipPos)	//Computes texture coordinate for sampling a GrabPass texure. Input is clip space position. The function takes care of platform differences in render texture coordinates.
float3 ShadeVertexLights (float4 vertex, float3 normal)	// Computes illumination from four per-vertex lights and ambient, given object space position & normal.

UnityObjectToWorldNormal(normal); // To convert normals to world space

tex2D(_Tex, float2); // Texture sampling

// #BUILT-IN VARIABLES

// #Transformations
// TODOL CHeck if these still work
UNITY_MATRIX_MVP	// Current model * view * projection matrix.
UNITY_MATRIX_MV	// Current model * view matrix.
UNITY_MATRIX_V	// Current view matrix.
UNITY_MATRIX_P	// Current projection matrix.
UNITY_MATRIX_VP	// Current view * projection matrix.
UNITY_MATRIX_T_MV	// Transpose of model * view matrix.
UNITY_MATRIX_IT_MV	// Inverse transpose of model * view matrix.

unity_WorldToObject // Inverse of current world matrix. _World2Object is obsolete
unity_ObjectToWorld // Current model matrix. _Object2World is obsolete

// To get UVs
newUV = TRANSFORM_TEX(oldUV, _MainTex); // replace with the name of your texture
// also remember to declare the float4 _MainTex_ST; variable before using the macro

// #Camera & Screen
_WorldSpaceCameraPos	// float3	World space position of the camera.
_ProjectionParams	// float4	x is 1.0 (or –1.0 if currently rendering with a flipped projection matrix), y is the camera’s near plane, z is the camera’s far plane and w is 1/FarPlane.
_ScreenParams	// float4	x is the camera’s render target width in pixels, y is the camera’s render target height in pixels, z is 1.0 + 1.0/width and w is 1.0 + 1.0/height.
_ZBufferParams	// float4	Used to linearize Z buffer values. x is (1-far/near), y is (far/near), z is (x/far) and w is (y/far).
unity_OrthoParams	// float4	x is orthographic camera’s width, y is orthographic camera’s height, z is unused and w is 1.0 when camera is orthographic, 0.0 when perspective.
unity_CameraProjection	// float4x4	Camera’s projection matrix.
unity_CameraInvProjection	// float4x4	Inverse of camera’s projection matrix.
unity_CameraWorldClipPlanes[6]	// float4	Camera frustum plane world space equations, in this order: left, right, bottom, top, near, far.

// #Time
_Time	// float4	Time since level load (t/20, t, t*2, t*3), use to animate things inside the shaders.
_SinTime	// float4	Sine of time: (t/8, t/4, t/2, t).
_CosTime	// float4	Cosine of time: (t/8, t/4, t/2, t).
unity_DeltaTime	// float4	Delta time: (dt, 1/dt, smoothDt, 1/smoothDt).

// #Lights
_LightColor0 // (declared in Lighting.cginc)	fixed4	Light color
_WorldSpaceLightPos0	// float4	Directional lights: (world space direction, 0). Other lights: (world space position, 1).
_LightMatrix0 // (declared in AutoLight.cginc)	float4x4	World-to-light matrix. Used to sample cookie & attenuation textures.
// forward only:
unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0	// float4	(ForwardBase pass only) world space positions of first four non-important point lights.
unity_4LightAtten0	// float4	(ForwardBase pass only) attenuation factors of first four non-important point lights.
unity_LightColor	// half4[4]	(ForwardBase pass only) colors of of first four non-important point lights.
// deffered:
_LightColor	//float4	Light color.
_LightMatrix0	//float4x4	World-to-light matrix. Used to sample cookie & attenuation textures.
// vertex lit:
unity_LightColor	// half4[8]	Light colors.
unity_LightPosition	// float4[8]	View-space light positions. (-direction,0) for directional lights; (position,1) for point/spot lights.
unity_LightAtten	// half4[8]	Light attenuation factors. x is cos(spotAngle/2) or –1 for non-spot lights; y is 1/cos(spotAngle/4) or 1 for non-spot lights; z is quadratic attenuation; w is squared light range.
unity_SpotDirection	// float4[8]	View-space spot light positions; (0,0,1,0) for non-spot lights.

// #Ambient
unity_AmbientSky	// fixed4	Sky ambient lighting color in gradient ambient lighting case.
unity_AmbientEquator	// fixed4	Equator ambient lighting color in gradient ambient lighting case.
unity_AmbientGround	// fixed4	Ground ambient lighting color in gradient ambient lighting case.

// #Fog
// UNITY_LIGHTMODEL_AMBIENT	// fixed4	Ambient lighting color (sky color in gradient ambient case). Legacy variable.
unity_FogColor	// fixed4	Fog color.
unity_FogParams	// float4	Parameters for fog calculation: (density / sqrt(ln(2)), density / ln(2), –1/(end-start), end/(end-start)). x is useful for Exp2 fog mode, y for Exp mode, z and w for Linear mode.

// #LOD
unity_LODFade	// float4	Level-of-detail fade when using LODGroup. x is fade (0..1), y is fade quantized to 16 levels, z and w unused.



//-------------------
//-- #TRANSPARENCY --
//-------------------


// #ALPHA TEST TRANSPARENCY == // (aka #CUTOFF, #CUTOUT)

// To make a thing transparent:
// Make sure you use have these 2 tags:
Tags {
	"Queue" = "AlphaTest" 
	"RenderType" = "TransparentCutout"
}

// In frag shader add:
clip(col.a - 0.5); // this 0.5 is the cutoff value, you can put it in a variable or property


// #ALPHA BLEND TRANSPARENCY

Tags { 
	"Queue"="Transparent" 
	"RenderType"="Transparent"
}

// Use one of the Blend modes see BLEND MODES
Blend SrcAlpha OneMinusSrcAlpha
ColorMask RGB
ZWrite Off
//Cull Off // optional

//----------
//-- #FOG --
//----------

// Unity provides some useful macros for implementing built-in fog that can be configured in Lighting tab
#pragma multi_compile_fog

#include "UnityCG.cginc"

// inside your v2f struct add:
struct v2f {
	...
	UNITY_FOG_COORDS(1) // the number (1) is an unused TEXCOORD-number, so if you already have TEXCOORD1, use (2)
}

// in the vert shader add UNITY_TRANSFER_FOG
v2f vert (appdata_t v) {
	v2f o;
	...
	UNITY_TRANSFER_FOG(o,o.vertex);
	return o;
}

// add UNITY_APPLY_FOG to your frag shader like
fixed4 frag (v2f i) : SV_Target {
	...
	UNITY_APPLY_FOG(i.fogCoord, col); // i.fogCoord is generated by UNITY_FOG_COORDS
	return col;
}


//-----------------------------------
//-- #GPU INSTANCING - #INSTANCING --
//-----------------------------------

#pragma multi_compile_instancing

#include "UnityCG.cginc"

struct appdata_t {
	...
	UNITY_VERTEX_INPUT_INSTANCE_ID
};

// It seems that this block required even tho you don't have any per instance properties
UNITY_INSTANCING_BUFFER_START(Props)
UNITY_DEFINE_INSTANCED_PROP(fixed4, _Color) // Make _Color an instanced property (i.e. an array)
#define _Color_arr Props
UNITY_INSTANCING_BUFFER_END(Props)

v2f vert (appdata_t v)
{
	v2f o;
	UNITY_SETUP_INSTANCE_ID(v);
	...
	return o;
}

//-------------------------------
//-- #VR - #STEREO SINGLE PASS --
//-------------------------------

// To support stereo single pass you need to put these macros to pass the eye index to the fragment shader.
// For example, if you’re using any of the view or projection matrices or the camera position in the fragment shader
// these need the eye index to give the correct value, otherwise you’ll always access the left eye.

#include "UnityCG.cginc"

struct appdata_t {
	...
	UNITY_VERTEX_INPUT_INSTANCE_ID
}

struct v2f {
	...
	UNITY_VERTEX_OUTPUT_STEREO
}

v2f vert (appdata_t v)
{
	v2f o;
	UNITY_SETUP_INSTANCE_ID(); // for single pass instanced. Not necessary?
	UNITY_INITIALIZE_OUTPUT(v2f, o); // for single pass instanced. Not necessary?
	UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
	...
	return o;
}

// in frag shader, eye can be accessed with
UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i)
// but it is not necessary, unless you are writing a post shader for example

//---------------------------------------------------
//-- #MULTI_COMPILE #SHADER KEYWORDS #KEYWORDS ------
//---------------------------------------------------

// using multi_compile directives enables making multiple shader variants #pragma multi_compile VARIANT_1 VARIANT_2 etc..

//-------------
// 2 VARIANTS

// with 2 variants, using __ will assume the "off" variant, you can write it like:
#pragma multi_compile __ THINGY

// use in code as:
#if defined(THINGY)
	// do something when enabled
#else
	// do something when disabled
#endif

// to create a property that will toggle it:
[Toggle(THINGY)] _Thingy("Thingy", Float) = 0 // the name of the property (_Thingy in this case) doesn't seem to be relevant

// or you can toggle from code using Shader.EnableKeyword/DisableKeyword or Material.EnableKeyword/DisableKeyword

//--------------------
// MULTIPLE VARIANTS

#pragma multi_compile _SOMETHING_THIS _SOMETHING_ELSE _SOMETHING_OTHERWISE

// use similar to the above:
#if defined(_SOMETHING_THIS)
	// do something only when SOMETHING_1 is defined
#endif

// Auto-property for more than 2 variants.
// Each name will enable "property name" + underscore + "enum name", uppercased, shader keyword. Up to 9 names can be provided.
[KeywordEnum(This, Else, Otherwise)] _Something("Something?", Float) = 0 // Here the property name IS relevant

//-------------------------------
//-- #SHADOW CASTING ------------
//-------------------------------

// incomplete, not tested

Pass
{
	Tags{ "LightMode" = "ShadowCaster" }

	Fog{ Mode Off }
	ZWrite On ZTest Less Cull Off
	Offset 1, 1

	CGPROGRAM
			
		#pragma vertex vert
		#pragma fragment frag
		#pragma multi_compile_shadowcaster
		#pragma fragmentoption ARB_precision_hint_fastest
		
		#include "UnityCG.cginc"

		struct v2f
		{
			V2F_SHADOW_CASTER;
		};

		v2f vert(appdata_base v)
		{
			v2f o;
			TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
			return o;
		}

		float4 frag(v2f i) : COLOR
		{
			SHADOW_CASTER_FRAGMENT(i)
		}

	ENDCG
}



//-----------------------------------------------//
//-----------------------------------------------//
//----------   SURFACE     SHADERS   ------------//
//-----------------------------------------------//
//-----------------------------------------------//

// #SURFACE SHADERS

Shader "Example/Diffuse Simple" 
{
	Properties // See PROPERTIES
	{
		
	}

    SubShader // Note, SubShader, unlike "Pass" in vert/frag shaders
    {
    	Tags // see tags. Note, tags inside the SubShader {} unlike vert/frag shaders

    	CGPROGRAM
    	#pragma surface surf Lambert
    	
    	struct Input {
    	    float4 color : COLOR;
    	};

    	void surf (Input IN, inout SurfaceOutput o) {
    	    o.Albedo = 1;
    	}

    	ENDCG
    }
    Fallback "Diffuse"
  }

//
IN.worldNormal
IN.viewDir