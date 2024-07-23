// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify/ASE_WorldCreator"
{
	Properties
	{
		[NoScaleOffset][Header (Main Property)]_SplatMap("SplatMap", 2D) = "white" {}
		[Toggle]_SplatMapRBGOnly("SplatMap (RBG) No Alpha", Float) = 1
		[NoScaleOffset][Normal]_WorldNormal("WorldNormal", 2D) = "bump" {}
		_WorldNormalScale("WorldNormalScale", Float) = 1
		_WorldAmbientScale("WorldAmbientScale", Float) = 0.5
		_WorldEmissionScale("WorldEmissionScale", Float) = 0.5
		[Header(Splatmap Red)]_ShadeR("Shade(R)", Color) = (1,1,1,0)
		[NoScaleOffset]_MainTexR("MainTex(R)", 2D) = "white" {}
		[NoScaleOffset][Normal]_BumpR("Bump(R)", 2D) = "bump" {}
		[Header(X Tiling Y Normal Z Metalic W Smoothness)]_CoordinateR("Coordinate(R)", Vector) = (1,1,0.5,0)
		_BrightnessR("Brightness(R)", Range( 0 , 2)) = 1
		_ContrastR("Contrast(R)", Range( 0 , 2)) = 1
		_MaskIntensityR("Mask Intensity(R)", Float) = 1
		_SmContrastR("Sm Contrast(R)", Range( 0.01 , 3)) = 1
		[Header(Splatmap Green)]_ShadeG("Shade(G)", Color) = (1,1,1,0)
		[NoScaleOffset]_MainTexG("MainTex(G)", 2D) = "white" {}
		[NoScaleOffset][Normal]_BumpG("Bump(G)", 2D) = "bump" {}
		[Header(X Tiling Y Normal Z Metalic W Smoothness)]_CoordinateG("Coordinate(G)", Vector) = (1,1,0.5,0)
		_BrightnessG("Brightness(G)", Range( 0 , 2)) = 1
		_ContrastG("Contrast(G)", Range( 0 , 2)) = 1
		_MaskIntensityG("Mask Intensity(G)", Float) = 1
		_SmContrastG("Sm Contrast(G)", Range( 0.01 , 3)) = 1
		[Header(Splatmap Blue)]_ShadeB("Shade(B)", Color) = (1,1,1,0)
		[NoScaleOffset]_MainTexB("MainTex(B)", 2D) = "white" {}
		[NoScaleOffset][Normal]_BumpB("Bump(B)", 2D) = "bump" {}
		[Header(X Tiling Y Normal Z Metalic W Smoothness)]_CoordinateB("Coordinate(B)", Vector) = (1,1,0.5,0)
		_BrightnessB("Brightness(B)", Range( 0 , 2)) = 1
		_ContrastB("Contrast(B)", Range( 0 , 2)) = 1
		_MaskIntensityB("Mask Intensity(B)", Float) = 1
		_SmContrastB("Sm Contrast(B)", Range( 0.01 , 3)) = 1
		[Header(Splatmap Alpha)]_ShadeA("Shade(A)", Color) = (1,1,1,0)
		[NoScaleOffset]_MainTexA("MainTex(A)", 2D) = "white" {}
		[NoScaleOffset][Normal]_BumpA("Bump(A)", 2D) = "bump" {}
		[Header(X Tiling Y Normal Z Metalic W Smoothness)]_CoordinateA("Coordinate(A)", Vector) = (1,1,0.5,0)
		_BrightnessA("Brightness(A)", Range( 0 , 2)) = 1
		_ContrastA("Contrast(A)", Range( 0 , 2)) = 1
		_MaskIntensityA("Mask Intensity(A)", Float) = 1
		_SmContrastA("Sm Contrast(A)", Range( 0.01 , 3)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred  
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _BumpR;
		uniform float4 _CoordinateR;
		uniform sampler2D _SplatMap;
		uniform float _MaskIntensityR;
		uniform sampler2D _BumpG;
		uniform float4 _CoordinateG;
		uniform float _MaskIntensityG;
		uniform sampler2D _BumpB;
		uniform float4 _CoordinateB;
		uniform float _MaskIntensityB;
		uniform sampler2D _BumpA;
		uniform float4 _CoordinateA;
		uniform float _SplatMapRBGOnly;
		uniform float _MaskIntensityA;
		uniform float _WorldNormalScale;
		uniform sampler2D _WorldNormal;
		uniform sampler2D _MainTexR;
		uniform float _ContrastR;
		uniform float4 _ShadeR;
		uniform float _BrightnessR;
		uniform sampler2D _MainTexG;
		uniform float _ContrastG;
		uniform float4 _ShadeG;
		uniform float _BrightnessG;
		uniform sampler2D _MainTexB;
		uniform float _ContrastB;
		uniform float4 _ShadeB;
		uniform float _BrightnessB;
		uniform sampler2D _MainTexA;
		uniform float _ContrastA;
		uniform float4 _ShadeA;
		uniform float _BrightnessA;
		uniform float _WorldAmbientScale;
		uniform float _WorldEmissionScale;
		uniform float _SmContrastR;
		uniform float _SmContrastG;
		uniform float _SmContrastB;
		uniform float _SmContrastA;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float BumpScaleR128 = _CoordinateR.y;
			float TileR70 = _CoordinateR.x;
			float2 temp_cast_0 = (TileR70).xx;
			float2 uv_TexCoord112 = i.uv_texcoord * temp_cast_0;
			float2 uv_SplatMap5 = i.uv_texcoord;
			float4 tex2DNode5 = tex2D( _SplatMap, uv_SplatMap5 );
			float clampResult227 = clamp( ( tex2DNode5.r * _MaskIntensityR ) , 0.0 , 1.0 );
			float MaskR229 = clampResult227;
			float3 lerpResult99 = lerp( float3( 0,0,0 ) , UnpackScaleNormal( tex2D( _BumpR, uv_TexCoord112 ), BumpScaleR128 ) , MaskR229);
			float BumpScaleG131 = _CoordinateG.y;
			float TileG72 = _CoordinateG.x;
			float2 temp_cast_1 = (TileG72).xx;
			float2 uv_TexCoord113 = i.uv_texcoord * temp_cast_1;
			float clampResult233 = clamp( ( tex2DNode5.g * _MaskIntensityG ) , 0.0 , 1.0 );
			float MaskG234 = clampResult233;
			float3 lerpResult103 = lerp( lerpResult99 , UnpackScaleNormal( tex2D( _BumpG, uv_TexCoord113 ), BumpScaleG131 ) , MaskG234);
			float BumpScaleB134 = _CoordinateB.y;
			float TileB74 = _CoordinateB.x;
			float2 temp_cast_2 = (TileB74).xx;
			float2 uv_TexCoord116 = i.uv_texcoord * temp_cast_2;
			float clampResult236 = clamp( ( tex2DNode5.b * _MaskIntensityB ) , 0.0 , 1.0 );
			float MaskB238 = clampResult236;
			float3 lerpResult106 = lerp( lerpResult103 , UnpackScaleNormal( tex2D( _BumpB, uv_TexCoord116 ), BumpScaleB134 ) , MaskB238);
			float TileA76 = _CoordinateA.x;
			float2 temp_cast_3 = (TileA76).xx;
			float2 uv_TexCoord117 = i.uv_texcoord * temp_cast_3;
			float clampResult240 = clamp( ( tex2DNode5.a * _MaskIntensityA ) , 0.0 , 1.0 );
			float MaskA241 = lerp(clampResult240,0.0,_SplatMapRBGOnly);
			float3 lerpResult107 = lerp( lerpResult106 , UnpackScaleNormal( tex2D( _BumpA, uv_TexCoord117 ), BumpScaleB134 ) , MaskA241);
			float2 uv_WorldNormal143 = i.uv_texcoord;
			float3 Normal108 = BlendNormals( lerpResult107 , UnpackScaleNormal( tex2D( _WorldNormal, uv_WorldNormal143 ), _WorldNormalScale ) );
			o.Normal = Normal108;
			float2 temp_cast_4 = (TileR70).xx;
			float2 uv_TexCoord68 = i.uv_texcoord * temp_cast_4;
			float4 tex2DNode56 = tex2D( _MainTexR, uv_TexCoord68 );
			float4 temp_cast_5 = (_ContrastR).xxxx;
			float4 lerpResult17 = lerp( float4( 0,0,0,0 ) , ( pow( tex2DNode56 , temp_cast_5 ) * _ShadeR * _BrightnessR ) , MaskR229);
			float2 temp_cast_6 = (TileG72).xx;
			float2 uv_TexCoord81 = i.uv_texcoord * temp_cast_6;
			float4 tex2DNode61 = tex2D( _MainTexG, uv_TexCoord81 );
			float4 temp_cast_7 = (_ContrastG).xxxx;
			float4 lerpResult20 = lerp( lerpResult17 , ( pow( tex2DNode61 , temp_cast_7 ) * _ShadeG * _BrightnessG ) , MaskG234);
			float2 temp_cast_8 = (TileB74).xx;
			float2 uv_TexCoord82 = i.uv_texcoord * temp_cast_8;
			float4 tex2DNode62 = tex2D( _MainTexB, uv_TexCoord82 );
			float4 temp_cast_9 = (_ContrastB).xxxx;
			float4 lerpResult23 = lerp( lerpResult20 , ( pow( tex2DNode62 , temp_cast_9 ) * _ShadeB * _BrightnessB ) , MaskB238);
			float2 temp_cast_10 = (TileA76).xx;
			float2 uv_TexCoord85 = i.uv_texcoord * temp_cast_10;
			float4 tex2DNode63 = tex2D( _MainTexA, uv_TexCoord85 );
			float4 temp_cast_11 = (_ContrastA).xxxx;
			float4 lerpResult25 = lerp( lerpResult23 , ( pow( tex2DNode63 , temp_cast_11 ) * _ShadeA * _BrightnessA ) , MaskA241);
			float4 FinalAlbedo66 = ( lerpResult25 * _WorldAmbientScale );
			float4 temp_output_67_0 = FinalAlbedo66;
			o.Albedo = temp_output_67_0.rgb;
			o.Emission = ( FinalAlbedo66 * _WorldEmissionScale ).rgb;
			float MetalicR130 = _CoordinateR.z;
			float lerpResult162 = lerp( 0.0 , MetalicR130 , MaskR229);
			float MetalicG132 = _CoordinateG.z;
			float lerpResult168 = lerp( lerpResult162 , MetalicG132 , MaskG234);
			float MetalicB135 = _CoordinateB.z;
			float lerpResult173 = lerp( lerpResult168 , MetalicB135 , MaskB238);
			float MetalicA138 = _CoordinateA.z;
			float lerpResult176 = lerp( lerpResult173 , MetalicA138 , MaskA241);
			float Metalic179 = lerpResult176;
			o.Metallic = Metalic179;
			float SmoothnessR129 = _CoordinateR.w;
			float lerpResult181 = lerp( 0.0 , pow( ( tex2DNode56.a * SmoothnessR129 ) , _SmContrastR ) , MaskR229);
			float SmoothnessG133 = _CoordinateG.w;
			float lerpResult182 = lerp( lerpResult181 , pow( ( tex2DNode61.a * SmoothnessG133 ) , _SmContrastG ) , MaskG234);
			float SmoothnessB136 = _CoordinateB.w;
			float lerpResult183 = lerp( lerpResult182 , pow( ( tex2DNode62.a * SmoothnessB136 ) , _SmContrastB ) , MaskB238);
			float SmoothnessA139 = _CoordinateA.w;
			float lerpResult184 = lerp( lerpResult183 , pow( ( tex2DNode63.a * SmoothnessA139 ) , _SmContrastA ) , MaskA241);
			float Smoothness185 = lerpResult184;
			o.Smoothness = Smoothness185;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
694;169;1652;1074;2214.574;-432.5576;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;77;-3841.429,-1235.037;Float;False;1595.844;546.7844;Channel_Value;20;76;74;72;70;124;125;126;127;128;129;130;131;132;133;134;135;136;137;138;139;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;243;-2201.951,-1706.459;Float;False;1914.702;999.737;Mask;20;241;260;262;240;238;234;236;239;242;233;229;235;237;232;227;231;226;5;225;64;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;124;-3810.315,-1159.882;Float;False;Property;_CoordinateR;Coordinate(R);9;0;Create;True;0;0;False;1;Header(X Tiling Y Normal Z Metalic W Smoothness);1,1,0.5,0;1,1,0.5,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;125;-3815.944,-889.3184;Float;False;Property;_CoordinateG;Coordinate(G);17;0;Create;True;0;0;False;1;Header(X Tiling Y Normal Z Metalic W Smoothness);1,1,0.5,0;1,1,0.5,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;64;-2151.951,-1656.459;Float;True;Property;_SplatMap;SplatMap;0;1;[NoScaleOffset];Create;True;0;0;False;1;Header (Main Property);None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;55;-3884.913,-653.2224;Float;False;3152.658;1859.897;Albedo;71;185;184;66;183;182;181;20;25;23;17;24;63;14;22;21;13;85;62;60;10;59;61;82;19;84;81;6;83;58;56;57;68;80;78;186;187;188;189;190;191;192;193;197;203;204;205;206;207;208;209;210;211;212;213;214;215;216;217;218;219;220;221;222;230;244;245;246;247;248;249;250;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;-3535.128,-1189.955;Float;False;TileR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1811.377,-1654.154;Float;True;Property;_MaskTex;MaskTex;10;2;[Gamma];[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;225;-1380.647,-1524.067;Float;False;Property;_MaskIntensityR;Mask Intensity(R);12;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;126;-3074.339,-1178.248;Float;False;Property;_CoordinateB;Coordinate(B);25;0;Create;True;0;0;False;1;Header(X Tiling Y Normal Z Metalic W Smoothness);1,1,0.5,0;1,1,0.5,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;78;-3856.344,-389.7887;Float;False;70;TileR;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;72;-3550.049,-925.2003;Float;False;TileG;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;226;-1146.648,-1643.068;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;74;-2852.836,-1185.859;Float;False;TileB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;127;-3052.623,-913.7399;Float;False;Property;_CoordinateA;Coordinate(A);33;0;Create;True;0;0;False;1;Header(X Tiling Y Normal Z Metalic W Smoothness);1,1,0.5,0;1,1,0.5,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;57;-3649.193,-601.9329;Float;True;Property;_MainTexR;MainTex(R);7;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;-3879.021,16.50178;Float;False;72;TileG;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;68;-3653.481,-405.9384;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;231;-1387.235,-1280.301;Float;False;Property;_MaskIntensityG;Mask Intensity(G);20;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;232;-1153.235,-1399.301;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;237;-1387.69,-1052.189;Float;False;Property;_MaskIntensityB;Mask Intensity(B);28;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;58;-3640.59,-211.1144;Float;True;Property;_MainTexG;MainTex(G);15;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;76;-2843.167,-937.1822;Float;False;TileA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;227;-902.6488,-1643.068;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;242;-1392.816,-833.1228;Float;False;Property;_MaskIntensityA;Mask Intensity(A);36;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;215;-3235.275,-412.2008;Float;False;Property;_ContrastR;Contrast(R);11;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;86;-3919.816,1224.791;Float;False;1838.922;1781.411;Normal;32;142;108;258;107;143;149;257;106;256;103;255;100;117;147;96;98;146;99;91;116;118;92;113;109;145;88;115;114;110;144;112;111;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;83;-3870.177,399.5092;Float;False;74;TileB;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;56;-3366.658,-610.6347;Float;True;Property;_TextureSample0;MainTex(R);6;2;[Gamma];[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;81;-3676.158,-1.416967;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-3059.192,-347.6136;Float;False;Property;_ShadeR;Shade(R);6;0;Create;True;0;0;False;1;Header(Splatmap Red);1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;216;-2920.275,-588.2008;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;239;-1158.817,-952.1227;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;128;-3320.895,-1153.976;Float;False;BumpScaleR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;82;-3667.315,381.5905;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;129;-3317.209,-991.7245;Float;False;SmoothnessR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;59;-3639.069,175.3422;Float;True;Property;_MainTexB;MainTex(B);23;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;211;-2832.066,-321.1266;Float;False;Property;_BrightnessR;Brightness(R);10;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;111;-3879.603,1483.819;Float;False;70;TileR;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;229;-750.6484,-1649.068;Float;False;MaskR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;235;-1153.691,-1171.189;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;218;-3302.658,-5.652155;Float;False;Property;_ContrastG;Contrast(G);19;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;-3358.512,-214.2935;Float;True;Property;_TextureSample1;Texture Sample 1;6;2;[Gamma];[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;84;-3861.332,783.4015;Float;False;76;TileA;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;233;-909.2362,-1399.301;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;110;-3676.09,1280.691;Float;True;Property;_BumpR;Bump(R);8;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;None;None;True;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ClampOpNode;240;-954.8182,-953.1227;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;85;-3658.469,765.4827;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-2688.12,-596.826;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;62;-3354.826,167.5736;Float;True;Property;_TextureSample2;Texture Sample 2;6;2;[Gamma];[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;60;-3626.803,538.9245;Float;True;Property;_MainTexA;MainTex(A);31;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;-3320.035,-892.2974;Float;False;BumpScaleG;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;262;-960.0294,-811.2754;Float;False;Constant;_Float0;Float 0;38;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;187;-2356.754,-422.149;Float;False;129;SmoothnessR;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;234;-757.2357,-1405.301;Float;False;MaskG;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;112;-3678.908,1477.329;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;220;-3235.994,370.7348;Float;False;Property;_ContrastB;Contrast(B);27;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;236;-909.6918,-1171.189;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;-3432.691,1566.958;Float;False;128;BumpScaleR;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;-2950.827,-21.16115;Float;False;Property;_ShadeG;Shade(G);14;0;Create;True;0;0;False;1;Header(Splatmap Green);1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;212;-2740.295,77.06947;Float;False;Property;_BrightnessG;Brightness(G);18;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;230;-2691.701,-432.8103;Float;False;229;MaskR;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;114;-3902.28,1890.111;Float;False;72;TileG;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;133;-3335.388,-777.4205;Float;False;SmoothnessG;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;217;-2987.658,-181.6522;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-2695.835,-210.2328;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;113;-3699.418,1872.192;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;213;-2724.696,442.3694;Float;False;Property;_BrightnessB;Brightness(B);26;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;109;-3362.271,1283.543;Float;True;Property;_TextureSample13;Texture Sample 13;6;2;[Gamma];[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;222;-3201.156,747.8965;Float;False;Property;_ContrastA;Contrast(A);35;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;208;-2380.662,-325.2223;Float;False;Property;_SmContrastR;Sm Contrast(R);13;0;Create;True;0;0;False;0;1;1;0.01;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;186;-2187.671,-499.3349;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-2943.288,361.3916;Float;False;Property;_ShadeB;Shade(B);22;0;Create;True;0;0;False;1;Header(Splatmap Blue);1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;63;-3317.034,535.8716;Float;True;Property;_TextureSample3;Texture Sample 3;6;2;[Gamma];[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;136;-2631.066,-992.0662;Float;False;SmoothnessB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;255;-3064.226,1354.435;Float;False;229;MaskR;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;134;-2637.807,-1115.636;Float;False;BumpScaleB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;244;-2503.531,-148.0579;Float;False;234;MaskG;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;88;-3663.849,1662.494;Float;True;Property;_BumpG;Bump(G);16;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;None;None;True;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;130;-3535.835,-1065.463;Float;False;MetalicR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;238;-757.6922,-1177.189;Float;False;MaskB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;17;-2484.221,-606.4727;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;145;-3442.095,1916.264;Float;False;131;BumpScaleG;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;219;-2951.1,180.3989;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;188;-2161.732,-47.08896;Float;False;133;SmoothnessG;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;260;-774.9293,-968.1753;Float;False;Property;_SplatMapRBGOnly;SplatMap (RBG) No Alpha;1;0;Create;False;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;150;-2035.5,1233.735;Float;False;778.4172;1033.458;Normal;13;179;254;163;176;159;253;173;168;154;252;251;162;151;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;115;-3893.437,2273.119;Float;False;74;TileB;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;-1944.311,372.9807;Float;False;136;SmoothnessB;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;250;-2001.313,-340.6573;Float;False;229;MaskR;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;139;-2635.956,-754.4077;Float;False;SmoothnessA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;245;-2293.965,236.6045;Float;False;238;MaskB;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;116;-3690.575,2255.2;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;91;-3364.833,1652.031;Float;True;Property;_TextureSample9;Texture Sample 9;6;2;[Gamma];[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;99;-2837.98,1271.541;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;146;-3430.005,2296.466;Float;False;134;BumpScaleB;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;132;-3556.035,-822.2974;Float;False;MetalicG;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;207;-2048.632,-519.4003;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;221;-2916.262,557.5605;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;256;-3046.878,1717.066;Float;False;234;MaskG;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;20;-2262.111,-238.4313;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-2693.534,170.8575;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;205;-2140.03,63.99221;Float;False;Property;_SmContrastG;Sm Contrast(G);21;0;Create;True;0;0;False;0;1;1;0.01;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-3884.591,2657.011;Float;False;76;TileA;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;214;-2670.094,726.1694;Float;False;Property;_BrightnessA;Brightness(A);34;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;92;-3660.705,2048.952;Float;True;Property;_BumpB;Bump(B);24;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;None;None;True;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;251;-1983.814,1402.829;Float;False;229;MaskR;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;151;-1972.628,1327.777;Float;False;130;MetalicR;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;189;-1995.573,-145.0392;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-2936.92,752.0577;Float;False;Property;_ShadeA;Shade(A);30;0;Create;True;0;0;False;1;Header(Splatmap Alpha);1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;241;-551.8184,-923.1227;Float;False;MaskA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;135;-2864.724,-1044.864;Float;False;MetalicB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;257;-3059.597,2121.625;Float;False;238;MaskB;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;181;-1880.923,-589.8997;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;154;-1981.156,1577.8;Float;False;132;MetalicG;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;192;-1807.612,728.0678;Float;False;139;SmoothnessA;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-2646.585,548.2696;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;23;-1998.235,146.6342;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;246;-2049.949,601.8307;Float;False;241;MaskA;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-3469.782,2697.656;Float;False;134;BumpScaleB;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;191;-1749.311,210.9806;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;103;-2845.874,1626.23;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;206;-1799.198,-123.8987;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;98;-3650.063,2412.534;Float;True;Property;_BumpA;Bump(A);32;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;None;None;True;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;252;-1978.388,1661.313;Float;False;234;MaskG;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;204;-1905.639,434.6685;Float;False;Property;_SmContrastB;Sm Contrast(B);29;0;Create;True;0;0;False;0;1;1;0.01;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;162;-1738.493,1308.989;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;249;-1897.63,-2.478561;Float;False;234;MaskG;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;117;-3681.729,2639.092;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;96;-3390.884,2048.767;Float;True;Property;_TextureSample11;Texture Sample 11;6;2;[Gamma];[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;203;-1604.639,182.6685;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;210;-1681.938,798.4852;Float;False;Property;_SmContrastA;Sm Contrast(A);37;0;Create;True;0;0;False;0;1;1;0.01;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;25;-1747.375,491.8499;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;258;-3062.415,2449.915;Float;False;241;MaskA;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;149;-3147.917,2915.484;Float;False;Property;_WorldNormalScale;WorldNormalScale;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;106;-2849.701,2022.867;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;193;-1506.731,552.4658;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;197;-1635.79,968.5798;Float;False;Property;_WorldAmbientScale;WorldAmbientScale;4;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;100;-3353.092,2417.065;Float;True;Property;_TextureSample12;Texture Sample 12;6;2;[Gamma];[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;138;-2838.887,-821.2321;Float;False;MetalicA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;159;-2005.232,1804.597;Float;False;135;MetalicB;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;248;-1603.577,328.7575;Float;False;238;MaskB;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;168;-1743.788,1549.435;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;253;-2011.478,1899.844;Float;False;238;MaskB;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;182;-1601.957,-201.5641;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;209;-1302.432,583.9266;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;107;-2835.561,2358.16;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;254;-2011.05,2118.087;Float;False;241;MaskA;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;247;-1335.561,802.9835;Float;False;241;MaskA;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;183;-1407.245,153.9772;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;143;-2932.055,2700.739;Float;True;Property;_WorldNormal;WorldNormal;2;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;163;-2016.082,2032.682;Float;False;138;MetalicA;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;173;-1741.545,1786.254;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;200;-1351.734,856.4004;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;176;-1749.77,2026.603;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;184;-1146.007,550.9971;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;142;-2563.061,2381.565;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;-1162.389,936.8923;Float;False;FinalAlbedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;179;-1477.99,2012.34;Float;False;Metalic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;67;-536.6344,-36.93486;Float;False;66;FinalAlbedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;108;-2319.4,2417.75;Float;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;224;-598.2788,147.7922;Float;False;Property;_WorldEmissionScale;WorldEmissionScale;5;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;185;-931.0324,856.1939;Float;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;180;-390.4139,325.3053;Float;False;179;Metalic;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;148;-404.0164,254.8102;Float;False;108;Normal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;194;-376.358,432.0814;Float;False;185;Smoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;-2630.203,-879.1268;Float;False;BumpScaleA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;-220.2788,135.7922;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;41.29109,102.0133;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Amplify/ASE_WorldCreator;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;1;;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;70;0;124;1
WireConnection;5;0;64;0
WireConnection;72;0;125;1
WireConnection;226;0;5;1
WireConnection;226;1;225;0
WireConnection;74;0;126;1
WireConnection;68;0;78;0
WireConnection;232;0;5;2
WireConnection;232;1;231;0
WireConnection;76;0;127;1
WireConnection;227;0;226;0
WireConnection;56;0;57;0
WireConnection;56;1;68;0
WireConnection;81;0;80;0
WireConnection;216;0;56;0
WireConnection;216;1;215;0
WireConnection;239;0;5;4
WireConnection;239;1;242;0
WireConnection;128;0;124;2
WireConnection;82;0;83;0
WireConnection;129;0;124;4
WireConnection;229;0;227;0
WireConnection;235;0;5;3
WireConnection;235;1;237;0
WireConnection;61;0;58;0
WireConnection;61;1;81;0
WireConnection;233;0;232;0
WireConnection;240;0;239;0
WireConnection;85;0;84;0
WireConnection;19;0;216;0
WireConnection;19;1;6;0
WireConnection;19;2;211;0
WireConnection;62;0;59;0
WireConnection;62;1;82;0
WireConnection;131;0;125;2
WireConnection;234;0;233;0
WireConnection;112;0;111;0
WireConnection;236;0;235;0
WireConnection;133;0;125;4
WireConnection;217;0;61;0
WireConnection;217;1;218;0
WireConnection;21;0;217;0
WireConnection;21;1;10;0
WireConnection;21;2;212;0
WireConnection;113;0;114;0
WireConnection;109;0;110;0
WireConnection;109;1;112;0
WireConnection;109;5;144;0
WireConnection;186;0;56;4
WireConnection;186;1;187;0
WireConnection;63;0;60;0
WireConnection;63;1;85;0
WireConnection;136;0;126;4
WireConnection;134;0;126;2
WireConnection;130;0;124;3
WireConnection;238;0;236;0
WireConnection;17;1;19;0
WireConnection;17;2;230;0
WireConnection;219;0;62;0
WireConnection;219;1;220;0
WireConnection;260;0;240;0
WireConnection;260;1;262;0
WireConnection;139;0;127;4
WireConnection;116;0;115;0
WireConnection;91;0;88;0
WireConnection;91;1;113;0
WireConnection;91;5;145;0
WireConnection;99;1;109;0
WireConnection;99;2;255;0
WireConnection;132;0;125;3
WireConnection;207;0;186;0
WireConnection;207;1;208;0
WireConnection;221;0;63;0
WireConnection;221;1;222;0
WireConnection;20;0;17;0
WireConnection;20;1;21;0
WireConnection;20;2;244;0
WireConnection;22;0;219;0
WireConnection;22;1;13;0
WireConnection;22;2;213;0
WireConnection;189;0;61;4
WireConnection;189;1;188;0
WireConnection;241;0;260;0
WireConnection;135;0;126;3
WireConnection;181;1;207;0
WireConnection;181;2;250;0
WireConnection;24;0;221;0
WireConnection;24;1;14;0
WireConnection;24;2;214;0
WireConnection;23;0;20;0
WireConnection;23;1;22;0
WireConnection;23;2;245;0
WireConnection;191;0;62;4
WireConnection;191;1;190;0
WireConnection;103;0;99;0
WireConnection;103;1;91;0
WireConnection;103;2;256;0
WireConnection;206;0;189;0
WireConnection;206;1;205;0
WireConnection;162;1;151;0
WireConnection;162;2;251;0
WireConnection;117;0;118;0
WireConnection;96;0;92;0
WireConnection;96;1;116;0
WireConnection;96;5;146;0
WireConnection;203;0;191;0
WireConnection;203;1;204;0
WireConnection;25;0;23;0
WireConnection;25;1;24;0
WireConnection;25;2;246;0
WireConnection;106;0;103;0
WireConnection;106;1;96;0
WireConnection;106;2;257;0
WireConnection;193;0;63;4
WireConnection;193;1;192;0
WireConnection;100;0;98;0
WireConnection;100;1;117;0
WireConnection;100;5;147;0
WireConnection;138;0;127;3
WireConnection;168;0;162;0
WireConnection;168;1;154;0
WireConnection;168;2;252;0
WireConnection;182;0;181;0
WireConnection;182;1;206;0
WireConnection;182;2;249;0
WireConnection;209;0;193;0
WireConnection;209;1;210;0
WireConnection;107;0;106;0
WireConnection;107;1;100;0
WireConnection;107;2;258;0
WireConnection;183;0;182;0
WireConnection;183;1;203;0
WireConnection;183;2;248;0
WireConnection;143;5;149;0
WireConnection;173;0;168;0
WireConnection;173;1;159;0
WireConnection;173;2;253;0
WireConnection;200;0;25;0
WireConnection;200;1;197;0
WireConnection;176;0;173;0
WireConnection;176;1;163;0
WireConnection;176;2;254;0
WireConnection;184;0;183;0
WireConnection;184;1;209;0
WireConnection;184;2;247;0
WireConnection;142;0;107;0
WireConnection;142;1;143;0
WireConnection;66;0;200;0
WireConnection;179;0;176;0
WireConnection;108;0;142;0
WireConnection;185;0;184;0
WireConnection;137;0;127;2
WireConnection;223;0;67;0
WireConnection;223;1;224;0
WireConnection;0;0;67;0
WireConnection;0;1;148;0
WireConnection;0;2;223;0
WireConnection;0;3;180;0
WireConnection;0;4;194;0
ASEEND*/
//CHKSM=803CAE375517673854D26B11BD77D5C3621AC787