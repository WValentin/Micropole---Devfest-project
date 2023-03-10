// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASE/ASE_StandartCutoutMoss"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_RimmMask("RimmMask", 2D) = "white" {}
		_AlbedoDetail("AlbedoDetail", 2D) = "white" {}
		_AlbedoColor("AlbedoColor", Color) = (1,1,1,1)
		_NormalMap("NormalMap", 2D) = "bump" {}
		_NormalMapDetail("NormalMapDetail", 2D) = "bump" {}
		_NormalExtraDetails("NormalExtraDetails", 2D) = "bump" {}
		[Toggle]_SmoothFromMapSwitch("SmoothFromMapSwitch", Float) = 1
		[Toggle]_SmoothRough("Smooth/Rough", Float) = 0
		_SmoothnessMap("SmoothnessMap", 2D) = "white" {}
		_MetallicMap("MetallicMap", 2D) = "white" {}
		_Snoothness("Snoothness", Float) = 1
		_Metallic("Metallic", Float) = 1
		_NormalMapDepth("NormalMapDepth", Float) = 1
		_NormalMapDetailsDeep("NormalMapDetailsDeep", Float) = 1
		_NormalExtraDetailsDeep("NormalExtraDetailsDeep", Float) = 1
		_RimColor("RimColor", Color) = (0,0,0,0)
		_RimScale("RimScale", Float) = 1
		_AlbedoDetailStrenth("AlbedoDetailStrenth", Float) = 1
		_RimPower("RimPower", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZWrite On
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			INTERNAL_DATA
			float3 worldNormal;
		};

		uniform float _NormalMapDepth;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float _NormalMapDetailsDeep;
		uniform sampler2D _NormalMapDetail;
		uniform float4 _NormalMapDetail_ST;
		uniform float _NormalExtraDetailsDeep;
		uniform sampler2D _NormalExtraDetails;
		uniform float4 _NormalExtraDetails_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _AlbedoColor;
		uniform float4 _RimColor;
		uniform float _RimScale;
		uniform float _RimPower;
		uniform sampler2D _RimmMask;
		uniform float4 _RimmMask_ST;
		uniform sampler2D _AlbedoDetail;
		uniform float4 _AlbedoDetail_ST;
		uniform float _AlbedoDetailStrenth;
		uniform float _Metallic;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
		uniform float _SmoothRough;
		uniform float _SmoothFromMapSwitch;
		uniform sampler2D _SmoothnessMap;
		uniform float4 _SmoothnessMap_ST;
		uniform float _Snoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float2 uv_NormalMapDetail = i.uv_texcoord * _NormalMapDetail_ST.xy + _NormalMapDetail_ST.zw;
			float2 uv_NormalExtraDetails = i.uv_texcoord * _NormalExtraDetails_ST.xy + _NormalExtraDetails_ST.zw;
			float3 temp_output_100_0 = BlendNormals( BlendNormals( UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalMapDepth ) , UnpackScaleNormal( tex2D( _NormalMapDetail, uv_NormalMapDetail ), _NormalMapDetailsDeep ) ) , UnpackScaleNormal( tex2D( _NormalExtraDetails, uv_NormalExtraDetails ), _NormalExtraDetailsDeep ) );
			o.Normal = temp_output_100_0;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 tex2DNode1 = tex2D( _Albedo, uv_Albedo );
			float4 temp_output_3_0 = ( tex2DNode1 * _AlbedoColor );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float fresnelNdotV75 = dot( mul(ase_tangentToWorldFast,temp_output_100_0), ase_worldViewDir );
			float fresnelNode75 = ( 0.0 + _RimScale * pow( 1.0 - fresnelNdotV75, _RimPower ) );
			float2 uv_RimmMask = i.uv_texcoord * _RimmMask_ST.xy + _RimmMask_ST.zw;
			float4 blendOpSrc96 = temp_output_3_0;
			float4 blendOpDest96 = ( ( _RimColor * fresnelNode75 ) * tex2D( _RimmMask, uv_RimmMask ) );
			float4 temp_output_96_0 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc96 ) * ( 1.0 - blendOpDest96 ) ) ));
			float2 uv_AlbedoDetail = i.uv_texcoord * _AlbedoDetail_ST.xy + _AlbedoDetail_ST.zw;
			float4 blendOpSrc103 = tex2D( _AlbedoDetail, uv_AlbedoDetail );
			float4 blendOpDest103 = temp_output_96_0;
			float4 lerpResult94 = lerp( temp_output_96_0 , ( saturate( (( blendOpDest103 > 0.5 ) ? ( 1.0 - 2.0 * ( 1.0 - blendOpDest103 ) * ( 1.0 - blendOpSrc103 ) ) : ( 2.0 * blendOpDest103 * blendOpSrc103 ) ) )) , _AlbedoDetailStrenth);
			o.Albedo = lerpResult94.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float4 tex2DNode5 = tex2D( _MetallicMap, uv_MetallicMap );
			float3 temp_cast_1 = (tex2DNode5.r).xxx;
			float3 temp_cast_2 = (tex2DNode5.r).xxx;
			float3 linearToGamma71 = LinearToGammaSpace( temp_cast_2 );
			o.Metallic = ( _Metallic * linearToGamma71 ).x;
			float3 temp_cast_4 = (tex2DNode5.a).xxx;
			float2 uv_SmoothnessMap = i.uv_texcoord * _SmoothnessMap_ST.xy + _SmoothnessMap_ST.zw;
			float3 temp_cast_5 = (tex2D( _SmoothnessMap, uv_SmoothnessMap ).r).xxx;
			float3 temp_cast_6 = (tex2D( _SmoothnessMap, uv_SmoothnessMap ).r).xxx;
			float3 linearToGamma72 = LinearToGammaSpace( temp_cast_6 );
			float3 temp_cast_7 = (tex2DNode5.a).xxx;
			float3 temp_cast_8 = (tex2D( _SmoothnessMap, uv_SmoothnessMap ).r).xxx;
			o.Smoothness = ( (( _SmoothRough )?( ( 1.0 - (( _SmoothFromMapSwitch )?( linearToGamma72 ):( temp_cast_7 )) ) ):( (( _SmoothFromMapSwitch )?( linearToGamma72 ):( temp_cast_4 )) )) * _Snoothness ).x;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18000
0;0;1920;1019;2199.128;903.6816;1.795283;True;True
Node;AmplifyShaderEditor.RangedFloatNode;91;-1706.016,-279.9868;Float;False;Property;_NormalMapDetailsDeep;NormalMapDetailsDeep;18;0;Create;True;0;0;False;0;1;1.13;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-1683.562,-553.7606;Float;False;Property;_NormalMapDepth;NormalMapDepth;17;0;Create;True;0;0;False;0;1;0.95;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-1272.402,-610.6142;Inherit;True;Property;_NormalMap;NormalMap;7;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;102;-1502.48,-131.3913;Float;False;Property;_NormalExtraDetailsDeep;NormalExtraDetailsDeep;19;0;Create;True;0;0;False;0;1;0.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;89;-1304.663,-380.1685;Inherit;True;Property;_NormalMapDetail;NormalMapDetail;8;0;Create;True;0;0;False;0;-1;None;b67df38490eda6241bcd4c33c55e5f1b;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;101;-1030.48,-203.3913;Inherit;True;Property;_NormalExtraDetails;NormalExtraDetails;9;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;90;-884.7529,-509.019;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;100;-768.4797,-411.3913;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-953.2848,-1145.992;Float;False;Property;_RimScale;RimScale;21;0;Create;True;0;0;False;0;1;1.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;78;-786.3458,-1593.323;Float;False;Property;_RimColor;RimColor;20;0;Create;True;0;0;False;0;0,0,0,0;0.9317506,0.9433962,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;73;-950.7683,-1071.841;Float;False;Property;_RimPower;RimPower;23;0;Create;True;0;0;False;0;1;0.76;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1493.196,239.5266;Inherit;True;Property;_SmoothnessMap;SmoothnessMap;13;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;79;-471.7287,-1579.608;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;75;-427.7999,-1178.928;Inherit;True;Standard;TangentNormal;ViewDir;False;False;5;0;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1512.996,6.426482;Inherit;True;Property;_MetallicMap;MetallicMap;14;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-331.8671,-927.1003;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;99;-319.5988,-1809.362;Inherit;True;Property;_RimmMask;RimmMask;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-247.1809,-1533.388;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LinearToGammaNode;72;-1162.188,332.8033;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;4;-407.9034,-673.7851;Float;False;Property;_AlbedoColor;AlbedoColor;3;0;Create;True;0;0;False;0;1,1,1,1;0.7263656,0.8018868,0.4425505,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;118.7282,-1461.205;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;46.16307,-926.1414;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;2;-896.6956,186.1265;Float;False;Property;_SmoothFromMapSwitch;SmoothFromMapSwitch;10;0;Create;True;0;0;False;0;1;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;12;-658.3749,320.7062;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;96;380.2228,-1418.937;Inherit;True;Screen;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;92;80.56796,-1756.301;Inherit;True;Property;_AlbedoDetail;AlbedoDetail;2;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;95;-88.14692,-662.0649;Float;False;Property;_AlbedoDetailStrenth;AlbedoDetailStrenth;22;0;Create;True;0;0;False;0;1;0.72;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;11;-508.8754,175.1064;Float;False;Property;_SmoothRough;Smooth/Rough;12;0;Create;True;0;0;False;0;0;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;103;1003.741,-1476.165;Inherit;True;Overlay;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.LinearToGammaNode;71;-1126.188,7.803253;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-461.2012,333.9779;Float;False;Property;_Snoothness;Snoothness;15;0;Create;True;0;0;False;0;1;0.17;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-644.9746,-14.00033;Float;False;Property;_Metallic;Metallic;16;0;Create;True;0;0;False;0;1;0.66;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-196.8749,160.8066;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;32;326.8384,-440.6982;Float;False;Property;_EmissionSwitch;EmissionSwitch;11;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;588.9876,-480.4108;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-293.0748,8.706559;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;123.9891,-534.4982;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;38;420.8224,-589.8196;Float;False;Property;_EmissionMultiplayer;EmissionMultiplayer;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;36;820.1939,-986.7106;Float;False;Property;_EmissionColor;EmissionColor;5;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;903.0311,-401.3935;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;94;473.775,-1054.336;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;33;-352.3483,-472.2335;Inherit;True;Property;_EmissionMap;EmissionMap;4;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;320.0717,-158.2859;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;ASE/ASE_StandartCutoutMoss;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;5;66;0
WireConnection;89;5;91;0
WireConnection;101;5;102;0
WireConnection;90;0;13;0
WireConnection;90;1;89;0
WireConnection;100;0;90;0
WireConnection;100;1;101;0
WireConnection;79;0;78;0
WireConnection;75;0;100;0
WireConnection;75;2;74;0
WireConnection;75;3;73;0
WireConnection;81;0;79;0
WireConnection;81;1;75;0
WireConnection;72;0;6;1
WireConnection;98;0;81;0
WireConnection;98;1;99;0
WireConnection;3;0;1;0
WireConnection;3;1;4;0
WireConnection;2;0;5;4
WireConnection;2;1;72;0
WireConnection;12;0;2;0
WireConnection;96;0;3;0
WireConnection;96;1;98;0
WireConnection;11;0;2;0
WireConnection;11;1;12;0
WireConnection;103;0;92;0
WireConnection;103;1;96;0
WireConnection;71;0;5;1
WireConnection;10;0;11;0
WireConnection;10;1;9;0
WireConnection;32;0;33;0
WireConnection;32;1;34;0
WireConnection;39;0;38;0
WireConnection;39;1;32;0
WireConnection;7;0;8;0
WireConnection;7;1;71;0
WireConnection;34;0;3;0
WireConnection;34;1;33;4
WireConnection;37;0;36;0
WireConnection;37;1;39;0
WireConnection;94;0;96;0
WireConnection;94;1;103;0
WireConnection;94;2;95;0
WireConnection;0;0;94;0
WireConnection;0;1;100;0
WireConnection;0;3;7;0
WireConnection;0;4;10;0
ASEEND*/
//CHKSM=852274684C9258499CC50E3DE825134C5A1D0CFA