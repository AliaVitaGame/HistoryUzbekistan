// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify/CustomSkybox"
{
	Properties
	{
		[Gamma][Header(Cubemap)]_Tint("Tint", Color) = (0.5,0.5,0.5,1)
		_Exposure("Exposure", Range( 0 , 8)) = 1
		_Contrast("Contrast", Float) = 1
		[NoScaleOffset]_Tex("Cubemap (HDR)", CUBE) = "black" {}
		[Header(Rotation)][Toggle(_ENABLEROTATION_ON)] _EnableRotation("Enable Rotation", Float) = 0
		[IntRange]_Rotation("Rotation", Range( 0 , 360)) = 0
		_RotationSpeed("Rotation Speed", Float) = 1
		[Header(Fog)][Toggle(_ENABLEFOG_ON)] _EnableFog("Enable Fog", Float) = 0
		[Toggle]_UseCustomColor("Use Custom Color", Float) = 1
		[HDR]_CustomFogTint("Custom Fog Tint", Color) = (0,0,0,0)
		_FogHeight("Fog Height", Range( 0 , 1)) = 1
		_FogSmoothness("Fog Smoothness", Range( 0.01 , 1)) = 0.01
		_FogFill("Fog Fill", Range( 0 , 1)) = 0.5
		[HideInInspector]_Tex_HDR("DecodeInstructions", Vector) = (0,0,0,0)
		_FogHorizonOffset("Fog Horizon Offset", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Background"  "Queue" = "Background+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  "PreviewType"="Skybox" }
		Cull Off
		ZWrite Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 2.0
		#pragma shader_feature _ENABLEFOG_ON
		#pragma shader_feature _ENABLEROTATION_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float3 vertexToFrag774;
			float3 worldPos;
		};

		uniform half4 _Tex_HDR;
		uniform samplerCUBE _Tex;
		uniform half _Rotation;
		uniform half _RotationSpeed;
		uniform float _Contrast;
		uniform half4 _Tint;
		uniform half _Exposure;
		uniform float _UseCustomColor;
		uniform float4 _CustomFogTint;
		uniform float _FogHorizonOffset;
		uniform half _FogHeight;
		uniform half _FogSmoothness;
		uniform half _FogFill;


		inline half3 DecodeHDR1189( half4 Data )
		{
			return DecodeHDR(Data, _Tex_HDR);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float lerpResult268 = lerp( 1.0 , ( unity_OrthoParams.y / unity_OrthoParams.x ) , unity_OrthoParams.w);
			half CAMERA_MODE300 = lerpResult268;
			float3 appendResult1129 = (float3(ase_worldPos.x , ( ase_worldPos.y * CAMERA_MODE300 ) , ase_worldPos.z));
			float3 normalizeResult1130 = normalize( appendResult1129 );
			float3 appendResult56 = (float3(cos( radians( ( _Rotation + ( _Time.y * _RotationSpeed ) ) ) ) , 0.0 , ( sin( radians( ( _Rotation + ( _Time.y * _RotationSpeed ) ) ) ) * -1.0 )));
			float3 appendResult266 = (float3(0.0 , CAMERA_MODE300 , 0.0));
			float3 appendResult58 = (float3(sin( radians( ( _Rotation + ( _Time.y * _RotationSpeed ) ) ) ) , 0.0 , cos( radians( ( _Rotation + ( _Time.y * _RotationSpeed ) ) ) )));
			float3 normalizeResult247 = normalize( ase_worldPos );
			#ifdef _ENABLEROTATION_ON
				float3 staticSwitch1164 = mul( float3x3(appendResult56, appendResult266, appendResult58), normalizeResult247 );
			#else
				float3 staticSwitch1164 = normalizeResult1130;
			#endif
			o.vertexToFrag774 = staticSwitch1164;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			half4 Data1189 = texCUBE( _Tex, i.vertexToFrag774 );
			half3 localDecodeHDR1189 = DecodeHDR1189( Data1189 );
			float3 temp_cast_1 = (_Contrast).xxx;
			half4 CUBEMAP222 = ( float4( pow( localDecodeHDR1189 , temp_cast_1 ) , 0.0 ) * unity_ColorSpaceDouble * _Tint * _Exposure );
			float3 ase_worldPos = i.worldPos;
			float3 normalizeResult319 = normalize( ase_worldPos );
			float lerpResult678 = lerp( saturate( pow( (0.0 + (abs( ( normalizeResult319.y + ( _FogHorizonOffset * 0.01 ) ) ) - 0.0) * (1.0 - 0.0) / (_FogHeight - 0.0)) , ( 1.0 - _FogSmoothness ) ) ) , 0.0 , _FogFill);
			half FOG_MASK359 = lerpResult678;
			float4 lerpResult317 = lerp( lerp(unity_FogColor,_CustomFogTint,_UseCustomColor) , CUBEMAP222 , FOG_MASK359);
			#ifdef _ENABLEFOG_ON
				float4 staticSwitch1179 = lerpResult317;
			#else
				float4 staticSwitch1179 = CUBEMAP222;
			#endif
			o.Emission = staticSwitch1179.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
2560;14;1906;1005;-1810.412;-1345.115;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;1180;-946,1486;Float;False;2411;608;Cubemap Coordinates;26;260;701;255;48;276;47;62;1080;59;1081;365;55;310;61;60;58;56;266;1127;238;1128;1129;54;247;49;1130;CUBEMAP;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;701;-896,1664;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;260;-896,1792;Half;False;Property;_RotationSpeed;Rotation Speed;6;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-896,1536;Half;False;Property;_Rotation;Rotation;5;1;[IntRange];Create;True;0;0;False;0;0;185;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;255;-640,1664;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;431;-940.4822,846.6917;Float;False;860;219;Switch between Perspective / Orthographic camera;4;268;309;267;1007;CAMERA MODE;1,0,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;276;-512,1536;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OrthoParams;267;-955.4822,896.6918;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;47;-384,1536;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1007;-439.4821,846.6918;Half;False;Constant;_Float7;Float 7;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;309;-588.4823,894.6918;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;62;-224,1792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;268;-252.4821,894.6918;Float;False;3;0;FLOAT;1;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;432;-44.48222,846.6917;Float;False;305;165;CAMERA MODE OUTPUT;1;300;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;300;3.51777,894.6918;Half;False;CAMERA_MODE;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;59;128,1600;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1080;128,1664;Half;False;Constant;_Float26;Float 26;50;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1127;768,1936;Float;False;300;CAMERA_MODE;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;310;128,1760;Float;False;300;CAMERA_MODE;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;61;128,1920;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;55;128,1536;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;700;-944,2512;Float;False;1898;485;Fog Coords on Screen;16;318;319;320;313;325;314;315;329;677;316;678;679;1109;1110;1197;1200;BUILT-IN FOG;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;320,1600;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1081;128,1840;Half;False;Constant;_Float27;Float 27;50;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;365;128,1984;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;238;768,1760;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;56;512,1536;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1128;1024,1920;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;266;512,1728;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;58;512,1920;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;318;-896,2560;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;1129;1152,1792;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;319;-640,2560;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;247;1024,1664;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1197;-525.502,2716.611;Float;False;Property;_FogHorizonOffset;Fog Horizon Offset;15;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.MatrixFromVectors;54;768,1536;Float;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;320;-448,2560;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;1087;1552,1664;Float;False;394;188;Enable Clouds Rotation;1;1164;;0,1,0.4980392,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;1130;1280,1792;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;1280,1616;Float;False;2;2;0;FLOAT3x3;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1200;-283.6558,2776.986;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1198;-169.6558,2651.986;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1183;1998,1678;Float;False;265;160;Per Vertex;1;774;;1,0,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;1164;1600,1728;Float;False;Property;_EnableRotation;Enable Rotation;4;0;Create;True;0;0;False;1;Header(Rotation);0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;325;-896,2880;Half;False;Property;_FogSmoothness;Fog Smoothness;11;0;Create;True;0;0;False;0;0.01;0.13;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1109;-128,2784;Half;False;Constant;_Float40;Float 40;55;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1191;2382,1486;Float;False;1115;565;Base;9;41;1173;1175;1174;1177;1190;1189;1192;1193;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.AbsOpNode;314;-106,2554;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;313;-896,2752;Half;False;Property;_FogHeight;Fog Height;10;0;Create;True;0;0;False;0;1;0.13;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;774;2048,1728;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;329;128,2880;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;2432,1536;Float;True;Property;_Tex;Cubemap (HDR);3;1;[NoScaleOffset];Create;False;0;0;False;0;None;41ed07e96c46f5b4ea2e2fba6311d771;True;0;False;black;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;315;64,2560;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1193;2820.446,1613.981;Float;False;Property;_Contrast;Contrast;2;0;Create;True;0;0;False;0;1;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1189;2816,1536;Half;False;DecodeHDR(Data, _Tex_HDR);3;False;1;True;Data;FLOAT4;0,0,0,0;In;;Float;False;DecodeHDR;True;False;0;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;677;320,2560;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1192;3067.784,1513.564;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1110;512,2753.3;Half;False;Constant;_Float41;Float 41;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1173;3050.936,1775.017;Half;False;Property;_Tint;Tint;0;1;[Gamma];Create;True;0;0;False;1;Header(Cubemap);0.5,0.5,0.5,1;0.4575472,0.7534305,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorSpaceDouble;1175;2820.246,1713.654;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;316;512,2560;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;679;512,2880;Half;False;Property;_FogFill;Fog Fill;12;0;Create;True;0;0;False;0;0.5;0.03;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1177;3031.122,1953.847;Half;False;Property;_Exposure;Exposure;1;0;Create;True;0;0;False;0;1;0.4;0;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1167;-1165.2,-96.39999;Float;False;851.6;485;;6;317;1194;228;436;1195;312;FINAL COLOR;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;699;1104,2512;Float;False;293;165;FOG_MASK OUTPUT;1;359;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1174;3328,1536;Float;False;4;4;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;915;3664,1488;Float;False;293;165;CUBEMAP OUTPUT;1;222;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;678;768,2560;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FogAndAmbientColorsNode;312;-1121.201,120.4;Float;False;unity_FogColor;0;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1195;-1126.93,-55.59539;Float;False;Property;_CustomFogTint;Custom Fog Tint;9;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.3269402,0.50623,0.745283,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;222;3712,1536;Half;False;CUBEMAP;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;359;1152,2560;Half;False;FOG_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1194;-836.3313,48.20461;Float;False;Property;_UseCustomColor;Use Custom Color;8;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;436;-1113.6,300.8001;Float;False;359;FOG_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;228;-1116.8,206.4;Float;False;222;CUBEMAP;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;317;-587.2002,92.79997;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1185;-274,174;Float;False;306;188;Enable Fog;1;1179;;0,1,0.4980392,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;1179;-224,224;Float;False;Property;_EnableFog;Enable Fog;7;0;Create;True;0;0;False;1;Header(Fog);0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;1190;2432,1792;Half;False;Property;_Tex_HDR;DecodeInstructions;14;1;[HideInInspector];Create;False;0;0;True;0;0,0,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;26;154,50;Float;False;True;0;Float;ASEMaterialInspector;0;0;Unlit;Amplify/CustomSkybox;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;True;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;False;0;True;Background;;Background;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;False;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;13;-1;-1;-1;1;PreviewType=Skybox;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;255;0;701;0
WireConnection;255;1;260;0
WireConnection;276;0;48;0
WireConnection;276;1;255;0
WireConnection;47;0;276;0
WireConnection;309;0;267;2
WireConnection;309;1;267;1
WireConnection;62;0;47;0
WireConnection;268;0;1007;0
WireConnection;268;1;309;0
WireConnection;268;2;267;4
WireConnection;300;0;268;0
WireConnection;59;0;62;0
WireConnection;61;0;62;0
WireConnection;55;0;62;0
WireConnection;60;0;59;0
WireConnection;60;1;1080;0
WireConnection;365;0;62;0
WireConnection;56;0;55;0
WireConnection;56;1;1081;0
WireConnection;56;2;60;0
WireConnection;1128;0;238;2
WireConnection;1128;1;1127;0
WireConnection;266;0;1081;0
WireConnection;266;1;310;0
WireConnection;266;2;1081;0
WireConnection;58;0;61;0
WireConnection;58;1;1081;0
WireConnection;58;2;365;0
WireConnection;1129;0;238;1
WireConnection;1129;1;1128;0
WireConnection;1129;2;238;3
WireConnection;319;0;318;0
WireConnection;247;0;238;0
WireConnection;54;0;56;0
WireConnection;54;1;266;0
WireConnection;54;2;58;0
WireConnection;320;0;319;0
WireConnection;1130;0;1129;0
WireConnection;49;0;54;0
WireConnection;49;1;247;0
WireConnection;1200;0;1197;0
WireConnection;1198;0;320;1
WireConnection;1198;1;1200;0
WireConnection;1164;1;1130;0
WireConnection;1164;0;49;0
WireConnection;314;0;1198;0
WireConnection;774;0;1164;0
WireConnection;329;0;325;0
WireConnection;41;1;774;0
WireConnection;315;0;314;0
WireConnection;315;2;313;0
WireConnection;315;4;1109;0
WireConnection;1189;0;41;0
WireConnection;677;0;315;0
WireConnection;677;1;329;0
WireConnection;1192;0;1189;0
WireConnection;1192;1;1193;0
WireConnection;316;0;677;0
WireConnection;1174;0;1192;0
WireConnection;1174;1;1175;0
WireConnection;1174;2;1173;0
WireConnection;1174;3;1177;0
WireConnection;678;0;316;0
WireConnection;678;1;1110;0
WireConnection;678;2;679;0
WireConnection;222;0;1174;0
WireConnection;359;0;678;0
WireConnection;1194;0;312;0
WireConnection;1194;1;1195;0
WireConnection;317;0;1194;0
WireConnection;317;1;228;0
WireConnection;317;2;436;0
WireConnection;1179;1;228;0
WireConnection;1179;0;317;0
WireConnection;26;2;1179;0
ASEEND*/
//CHKSM=BF50A39CF571464E7AF529737037F4780B1E708B