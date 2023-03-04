// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASE/ASE_StandartInnerGlow"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		_InnerGlowMask("InnerGlowMask", 2D) = "white" {}
		_SructureGlowTexture("SructureGlowTexture", 2D) = "white" {}
		_StructureColor("StructureColor", Color) = (0,0,0,0)
		_InnerStructMapTilling("InnerStructMapTilling", Float) = 0
		_StructureGlowIntens("StructureGlowIntens", Float) = 0
		_FresnelPower("FresnelPower", Float) = 0
		_FresnelScale("FresnelScale", Float) = 1
		_InnerStructureDepth("InnerStructureDepth", Float) = 0
		_HeightMultiplayer("HeightMultiplayer", Float) = 0
		_InnerHeightMap("InnerHeightMap", 2D) = "white" {}
		_Albedo("Albedo", 2D) = "white" {}
		_AlbedoColor("AlbedoColor", Color) = (1,1,1,1)
		_EmissionMap("EmissionMap", 2D) = "white" {}
		_EmissionColor("EmissionColor", Color) = (0,0,0,0)
		_EmissionMultiplayer("EmissionMultiplayer", Float) = 0
		_RimBias("RimBias", Float) = 0
		_RimPower("RimPower", Float) = 1
		_RimIntens("RimIntens", Float) = 10
		_RimColor("RimColor", Color) = (1,1,1,0)
		_NormalMap("NormalMap", 2D) = "bump" {}
		[Toggle]_SmoothFromMapSwitch("SmoothFromMapSwitch", Float) = 1
		[Toggle]_EmissionSwitch("EmissionSwitch", Float) = 0
		[Toggle]_SmoothRough("Smooth/Rough", Float) = 0
		_SmoothnessMap("SmoothnessMap", 2D) = "white" {}
		_MetallicMap("MetallicMap", 2D) = "white" {}
		_Snoothness("Snoothness", Float) = 1
		_Metallic("Metallic", Float) = 1
		_NormalMapDepth("NormalMapDepth", Float) = 1
		_MetalicBrightnes("MetalicBrightnes", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		
		Cull Back
		HLSLINCLUDE
		#pragma target 2.0
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend One Zero , One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile _ _SHADOWS_SOFT
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_FORWARD

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			
			#if ASE_SRP_VERSION <= 70108
			#define REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT


			sampler2D _InnerGlowMask;
			sampler2D _NormalMap;
			sampler2D _SructureGlowTexture;
			sampler2D _InnerHeightMap;
			sampler2D _Albedo;
			sampler2D _EmissionMap;
			sampler2D _MetallicMap;
			sampler2D _SmoothnessMap;
			CBUFFER_START( UnityPerMaterial )
			float4 _InnerGlowMask_ST;
			float _NormalMapDepth;
			float4 _NormalMap_ST;
			float _FresnelScale;
			float _FresnelPower;
			float _StructureGlowIntens;
			float4 _StructureColor;
			float _InnerStructMapTilling;
			float4 _InnerHeightMap_ST;
			float _HeightMultiplayer;
			float _InnerStructureDepth;
			float4 _Albedo_ST;
			float4 _AlbedoColor;
			float4 _RimColor;
			float _RimBias;
			float _RimIntens;
			float _RimPower;
			float4 _EmissionColor;
			float _EmissionMultiplayer;
			float _EmissionSwitch;
			float4 _EmissionMap_ST;
			float _Metallic;
			float4 _MetallicMap_ST;
			float _MetalicBrightnes;
			float _SmoothRough;
			float _SmoothFromMapSwitch;
			float4 _SmoothnessMap_ST;
			float _Snoothness;
			CBUFFER_END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 lightmapUVOrVertexSH : TEXCOORD0;
				half4 fogFactorAndVertexLight : TEXCOORD1;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
			VertexOutput vert ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord7.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 positionVS = TransformWorldToView( positionWS );
				float4 positionCS = TransformWorldToHClip( positionWS );

				VertexNormalInputs normalInput = GetVertexNormalInputs( v.ase_normal, v.ase_tangent );

				o.tSpace0 = float4( normalInput.normalWS, positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, positionWS.z);

				OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );

				half3 vertexLight = VertexLighting( positionWS, normalInput.normalWS );
				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( positionCS.z );
				#else
					half fogFactor = 0;
				#endif
				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
				
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				
				o.clipPos = positionCS;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				o.screenPos = ComputeScreenPos(positionCS);
				#endif
				return o;
			}

			half4 frag ( VertexOutput IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				float3 WorldNormal = normalize( IN.tSpace0.xyz );
				float3 WorldTangent = IN.tSpace1.xyz;
				float3 WorldBiTangent = IN.tSpace2.xyz;
				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif
	
				#if SHADER_HINT_NICE_QUALITY
					WorldViewDirection = SafeNormalize( WorldViewDirection );
				#endif

				float2 uv_InnerGlowMask = IN.ase_texcoord7.xy * _InnerGlowMask_ST.xy + _InnerGlowMask_ST.zw;
				float4 tex2DNode129 = tex2D( _InnerGlowMask, uv_InnerGlowMask );
				float2 uv_NormalMap = IN.ase_texcoord7.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
				float3 tex2DNode13 = UnpackNormalScale( tex2D( _NormalMap, uv_NormalMap ), _NormalMapDepth );
				float3 tanToWorld0 = float3( WorldTangent.x, WorldBiTangent.x, WorldNormal.x );
				float3 tanToWorld1 = float3( WorldTangent.y, WorldBiTangent.y, WorldNormal.y );
				float3 tanToWorld2 = float3( WorldTangent.z, WorldBiTangent.z, WorldNormal.z );
				float3 tanNormal119 = tex2DNode13;
				float fresnelNdotV119 = dot( float3(dot(tanToWorld0,tanNormal119), dot(tanToWorld1,tanNormal119), dot(tanToWorld2,tanNormal119)), WorldViewDirection );
				float fresnelNode119 = ( 0.0 + _FresnelScale * pow( 1.0 - fresnelNdotV119, _FresnelPower ) );
				float clampResult128 = clamp( fresnelNode119 , 0.0 , 1.0 );
				float2 temp_cast_0 = (_InnerStructMapTilling).xx;
				float2 uv0151 = IN.ase_texcoord7.xy * temp_cast_0 + float2( 0,0 );
				float2 uv_InnerHeightMap = IN.ase_texcoord7.xy * _InnerHeightMap_ST.xy + _InnerHeightMap_ST.zw;
				float temp_output_137_0 = ( tex2D( _InnerHeightMap, uv_InnerHeightMap ).r * _HeightMultiplayer );
				float2 Offset112 = ( ( temp_output_137_0 - 1 ) * WorldViewDirection.xy * _InnerStructureDepth ) + uv0151;
				float2 temp_cast_1 = (_InnerStructMapTilling).xx;
				float2 temp_cast_2 = (0.2).xx;
				float2 uv0113 = IN.ase_texcoord7.xy * temp_cast_1 + temp_cast_2;
				float2 Offset140 = ( ( temp_output_137_0 - 1 ) * WorldViewDirection.xy * ( _InnerStructureDepth * 2.0 ) ) + uv0113;
				float2 uv_Albedo = IN.ase_texcoord7.xy * _Albedo_ST.xy + _Albedo_ST.zw;
				float4 temp_output_3_0 = ( tex2D( _Albedo, uv_Albedo ) * _AlbedoColor );
				float4 temp_output_130_0 = ( tex2DNode129.r * ( ( ( 1.0 - clampResult128 ) * ( _StructureGlowIntens * ( _StructureColor * ( tex2D( _SructureGlowTexture, Offset112 ) + ( tex2D( _SructureGlowTexture, Offset140 ) * 0.6 ) ) ) ) ) * temp_output_3_0 ) );
				float4 temp_output_109_0 = ( temp_output_130_0 + temp_output_3_0 );
				float3 tanNormal153 = tex2DNode13;
				float fresnelNdotV153 = dot( float3(dot(tanToWorld0,tanNormal153), dot(tanToWorld1,tanNormal153), dot(tanToWorld2,tanNormal153)), WorldViewDirection );
				float fresnelNode153 = ( _RimBias + _RimIntens * pow( 1.0 - fresnelNdotV153, _RimPower ) );
				float clampResult161 = clamp( fresnelNode153 , 0.0 , 1.0 );
				float lerpResult165 = lerp( 0.0 , ( 1.0 - clampResult161 ) , tex2DNode129.r);
				float4 lerpResult167 = lerp( temp_output_109_0 , ( _RimColor * temp_output_109_0 ) , lerpResult165);
				
				float2 uv_EmissionMap = IN.ase_texcoord7.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
				float4 tex2DNode33 = tex2D( _EmissionMap, uv_EmissionMap );
				
				float2 uv_MetallicMap = IN.ase_texcoord7.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
				float4 tex2DNode5 = tex2D( _MetallicMap, uv_MetallicMap );
				float3 linearToGamma105 = FastLinearToSRGB( tex2DNode5.rgb );
				float lerpResult93 = lerp( linearToGamma105.x , 1.0 , _MetalicBrightnes);
				
				float2 uv_SmoothnessMap = IN.ase_texcoord7.xy * _SmoothnessMap_ST.xy + _SmoothnessMap_ST.zw;
				float3 linearToGamma103 = FastLinearToSRGB( tex2D( _SmoothnessMap, uv_SmoothnessMap ).rgb );
				
				float3 Albedo = lerpResult167.rgb;
				float3 Normal = tex2DNode13;
				float3 Emission = ( ( _EmissionColor * temp_output_130_0 ) + ( _EmissionMultiplayer * (( _EmissionSwitch )?( ( temp_output_3_0 * tex2DNode33.a ) ):( tex2DNode33 )) ) ).rgb;
				float3 Specular = 0.5;
				float Metallic = ( _Metallic * lerpResult93 );
				float Smoothness = ( (( _SmoothRough )?( ( 1.0 - (( _SmoothFromMapSwitch )?( linearToGamma103.z ):( tex2DNode5.a )) ) ):( (( _SmoothFromMapSwitch )?( linearToGamma103.z ):( tex2DNode5.a )) )) * _Snoothness );
				float Occlusion = 1;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				
				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData;
				inputData.positionWS = WorldPosition;
				inputData.viewDirectionWS = WorldViewDirection;
				inputData.shadowCoord = ShadowCoords;

				#ifdef _NORMALMAP
					inputData.normalWS = normalize(TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal )));
				#else
					#if !SHADER_HINT_NICE_QUALITY
						inputData.normalWS = WorldNormal;
					#else
						inputData.normalWS = normalize( WorldNormal );
					#endif
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;
				inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, IN.lightmapUVOrVertexSH.xyz, inputData.normalWS );
				#ifdef _ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif
				half4 color = UniversalFragmentPBR(
					inputData, 
					Albedo, 
					Metallic, 
					Specular, 
					Smoothness, 
					Occlusion, 
					Emission, 
					Alpha);

				#ifdef _REFRACTION_ASE
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, WorldNormal ).xyz * ( 1.0 / ( ScreenPos.z + 1.0 ) ) * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					float2 cameraRefraction = float2( refractionOffset.x, -( refractionOffset.y * _ProjectionParams.x ) );
					projScreenPos.xy += cameraRefraction;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif
				
				return color;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex ShadowPassVertex
			#pragma fragment ShadowPassFragment

			#define SHADERPASS_SHADOWCASTER

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			CBUFFER_START( UnityPerMaterial )
			float4 _InnerGlowMask_ST;
			float _NormalMapDepth;
			float4 _NormalMap_ST;
			float _FresnelScale;
			float _FresnelPower;
			float _StructureGlowIntens;
			float4 _StructureColor;
			float _InnerStructMapTilling;
			float4 _InnerHeightMap_ST;
			float _HeightMultiplayer;
			float _InnerStructureDepth;
			float4 _Albedo_ST;
			float4 _AlbedoColor;
			float4 _RimColor;
			float _RimBias;
			float _RimIntens;
			float _RimPower;
			float4 _EmissionColor;
			float _EmissionMultiplayer;
			float _EmissionSwitch;
			float4 _EmissionMap_ST;
			float _Metallic;
			float4 _MetallicMap_ST;
			float _MetalicBrightnes;
			float _SmoothRough;
			float _SmoothFromMapSwitch;
			float4 _SmoothnessMap_ST;
			float _Snoothness;
			CBUFFER_END


			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
			float3 _LightDirection;

			VertexOutput ShadowPassVertex( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif
				float3 normalWS = TransformObjectToWorldDir(v.ase_normal);

				float4 clipPos = TransformWorldToHClip( ApplyShadowBias( positionWS, normalWS, _LightDirection ) );

				#if UNITY_REVERSED_Z
					clipPos.z = min(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#else
					clipPos.z = max(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = clipPos;
				return o;
			}

			half4 ShadowPassFragment(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );
				
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			

			CBUFFER_START( UnityPerMaterial )
			float4 _InnerGlowMask_ST;
			float _NormalMapDepth;
			float4 _NormalMap_ST;
			float _FresnelScale;
			float _FresnelPower;
			float _StructureGlowIntens;
			float4 _StructureColor;
			float _InnerStructMapTilling;
			float4 _InnerHeightMap_ST;
			float _HeightMultiplayer;
			float _InnerStructureDepth;
			float4 _Albedo_ST;
			float4 _AlbedoColor;
			float4 _RimColor;
			float _RimBias;
			float _RimIntens;
			float _RimPower;
			float4 _EmissionColor;
			float _EmissionMultiplayer;
			float _EmissionSwitch;
			float4 _EmissionMap_ST;
			float _Metallic;
			float4 _MetallicMap_ST;
			float _MetalicBrightnes;
			float _SmoothRough;
			float _SmoothFromMapSwitch;
			float4 _SmoothnessMap_ST;
			float _Snoothness;
			CBUFFER_END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
			VertexOutput vert( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;
				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_META

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL


			sampler2D _InnerGlowMask;
			sampler2D _NormalMap;
			sampler2D _SructureGlowTexture;
			sampler2D _InnerHeightMap;
			sampler2D _Albedo;
			sampler2D _EmissionMap;
			CBUFFER_START( UnityPerMaterial )
			float4 _InnerGlowMask_ST;
			float _NormalMapDepth;
			float4 _NormalMap_ST;
			float _FresnelScale;
			float _FresnelPower;
			float _StructureGlowIntens;
			float4 _StructureColor;
			float _InnerStructMapTilling;
			float4 _InnerHeightMap_ST;
			float _HeightMultiplayer;
			float _InnerStructureDepth;
			float4 _Albedo_ST;
			float4 _AlbedoColor;
			float4 _RimColor;
			float _RimBias;
			float _RimIntens;
			float _RimPower;
			float4 _EmissionColor;
			float _EmissionMultiplayer;
			float _EmissionSwitch;
			float4 _EmissionMap_ST;
			float _Metallic;
			float4 _MetallicMap_ST;
			float _MetalicBrightnes;
			float _SmoothRough;
			float _SmoothFromMapSwitch;
			float4 _SmoothnessMap_ST;
			float _Snoothness;
			CBUFFER_END


			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
			VertexOutput vert( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord3.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord4.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				o.clipPos = MetaVertexPosition( v.vertex, v.texcoord1.xy, v.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = o.clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				return o;
			}

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_InnerGlowMask = IN.ase_texcoord2.xy * _InnerGlowMask_ST.xy + _InnerGlowMask_ST.zw;
				float4 tex2DNode129 = tex2D( _InnerGlowMask, uv_InnerGlowMask );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float2 uv_NormalMap = IN.ase_texcoord2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
				float3 tex2DNode13 = UnpackNormalScale( tex2D( _NormalMap, uv_NormalMap ), _NormalMapDepth );
				float3 ase_worldTangent = IN.ase_texcoord3.xyz;
				float3 ase_worldNormal = IN.ase_texcoord4.xyz;
				float3 ase_worldBitangent = IN.ase_texcoord5.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal119 = tex2DNode13;
				float fresnelNdotV119 = dot( float3(dot(tanToWorld0,tanNormal119), dot(tanToWorld1,tanNormal119), dot(tanToWorld2,tanNormal119)), ase_worldViewDir );
				float fresnelNode119 = ( 0.0 + _FresnelScale * pow( 1.0 - fresnelNdotV119, _FresnelPower ) );
				float clampResult128 = clamp( fresnelNode119 , 0.0 , 1.0 );
				float2 temp_cast_0 = (_InnerStructMapTilling).xx;
				float2 uv0151 = IN.ase_texcoord2.xy * temp_cast_0 + float2( 0,0 );
				float2 uv_InnerHeightMap = IN.ase_texcoord2.xy * _InnerHeightMap_ST.xy + _InnerHeightMap_ST.zw;
				float temp_output_137_0 = ( tex2D( _InnerHeightMap, uv_InnerHeightMap ).r * _HeightMultiplayer );
				float2 Offset112 = ( ( temp_output_137_0 - 1 ) * ase_worldViewDir.xy * _InnerStructureDepth ) + uv0151;
				float2 temp_cast_1 = (_InnerStructMapTilling).xx;
				float2 temp_cast_2 = (0.2).xx;
				float2 uv0113 = IN.ase_texcoord2.xy * temp_cast_1 + temp_cast_2;
				float2 Offset140 = ( ( temp_output_137_0 - 1 ) * ase_worldViewDir.xy * ( _InnerStructureDepth * 2.0 ) ) + uv0113;
				float2 uv_Albedo = IN.ase_texcoord2.xy * _Albedo_ST.xy + _Albedo_ST.zw;
				float4 temp_output_3_0 = ( tex2D( _Albedo, uv_Albedo ) * _AlbedoColor );
				float4 temp_output_130_0 = ( tex2DNode129.r * ( ( ( 1.0 - clampResult128 ) * ( _StructureGlowIntens * ( _StructureColor * ( tex2D( _SructureGlowTexture, Offset112 ) + ( tex2D( _SructureGlowTexture, Offset140 ) * 0.6 ) ) ) ) ) * temp_output_3_0 ) );
				float4 temp_output_109_0 = ( temp_output_130_0 + temp_output_3_0 );
				float3 tanNormal153 = tex2DNode13;
				float fresnelNdotV153 = dot( float3(dot(tanToWorld0,tanNormal153), dot(tanToWorld1,tanNormal153), dot(tanToWorld2,tanNormal153)), ase_worldViewDir );
				float fresnelNode153 = ( _RimBias + _RimIntens * pow( 1.0 - fresnelNdotV153, _RimPower ) );
				float clampResult161 = clamp( fresnelNode153 , 0.0 , 1.0 );
				float lerpResult165 = lerp( 0.0 , ( 1.0 - clampResult161 ) , tex2DNode129.r);
				float4 lerpResult167 = lerp( temp_output_109_0 , ( _RimColor * temp_output_109_0 ) , lerpResult165);
				
				float2 uv_EmissionMap = IN.ase_texcoord2.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
				float4 tex2DNode33 = tex2D( _EmissionMap, uv_EmissionMap );
				
				
				float3 Albedo = lerpResult167.rgb;
				float3 Emission = ( ( _EmissionColor * temp_output_130_0 ) + ( _EmissionMultiplayer * (( _EmissionSwitch )?( ( temp_output_3_0 * tex2DNode33.a ) ):( tex2DNode33 )) ) ).rgb;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = Albedo;
				metaInput.Emission = Emission;
				
				return MetaFragment(metaInput);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend One Zero , One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			#pragma enable_d3d11_debug_symbols
			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_2D

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL


			sampler2D _InnerGlowMask;
			sampler2D _NormalMap;
			sampler2D _SructureGlowTexture;
			sampler2D _InnerHeightMap;
			sampler2D _Albedo;
			CBUFFER_START( UnityPerMaterial )
			float4 _InnerGlowMask_ST;
			float _NormalMapDepth;
			float4 _NormalMap_ST;
			float _FresnelScale;
			float _FresnelPower;
			float _StructureGlowIntens;
			float4 _StructureColor;
			float _InnerStructMapTilling;
			float4 _InnerHeightMap_ST;
			float _HeightMultiplayer;
			float _InnerStructureDepth;
			float4 _Albedo_ST;
			float4 _AlbedoColor;
			float4 _RimColor;
			float _RimBias;
			float _RimIntens;
			float _RimPower;
			float4 _EmissionColor;
			float _EmissionMultiplayer;
			float _EmissionSwitch;
			float4 _EmissionMap_ST;
			float _Metallic;
			float4 _MetallicMap_ST;
			float _MetalicBrightnes;
			float _SmoothRough;
			float _SmoothFromMapSwitch;
			float4 _SmoothnessMap_ST;
			float _Snoothness;
			CBUFFER_END


			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
			VertexOutput vert( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord3.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord4.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				return o;
			}

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_InnerGlowMask = IN.ase_texcoord2.xy * _InnerGlowMask_ST.xy + _InnerGlowMask_ST.zw;
				float4 tex2DNode129 = tex2D( _InnerGlowMask, uv_InnerGlowMask );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float2 uv_NormalMap = IN.ase_texcoord2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
				float3 tex2DNode13 = UnpackNormalScale( tex2D( _NormalMap, uv_NormalMap ), _NormalMapDepth );
				float3 ase_worldTangent = IN.ase_texcoord3.xyz;
				float3 ase_worldNormal = IN.ase_texcoord4.xyz;
				float3 ase_worldBitangent = IN.ase_texcoord5.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal119 = tex2DNode13;
				float fresnelNdotV119 = dot( float3(dot(tanToWorld0,tanNormal119), dot(tanToWorld1,tanNormal119), dot(tanToWorld2,tanNormal119)), ase_worldViewDir );
				float fresnelNode119 = ( 0.0 + _FresnelScale * pow( 1.0 - fresnelNdotV119, _FresnelPower ) );
				float clampResult128 = clamp( fresnelNode119 , 0.0 , 1.0 );
				float2 temp_cast_0 = (_InnerStructMapTilling).xx;
				float2 uv0151 = IN.ase_texcoord2.xy * temp_cast_0 + float2( 0,0 );
				float2 uv_InnerHeightMap = IN.ase_texcoord2.xy * _InnerHeightMap_ST.xy + _InnerHeightMap_ST.zw;
				float temp_output_137_0 = ( tex2D( _InnerHeightMap, uv_InnerHeightMap ).r * _HeightMultiplayer );
				float2 Offset112 = ( ( temp_output_137_0 - 1 ) * ase_worldViewDir.xy * _InnerStructureDepth ) + uv0151;
				float2 temp_cast_1 = (_InnerStructMapTilling).xx;
				float2 temp_cast_2 = (0.2).xx;
				float2 uv0113 = IN.ase_texcoord2.xy * temp_cast_1 + temp_cast_2;
				float2 Offset140 = ( ( temp_output_137_0 - 1 ) * ase_worldViewDir.xy * ( _InnerStructureDepth * 2.0 ) ) + uv0113;
				float2 uv_Albedo = IN.ase_texcoord2.xy * _Albedo_ST.xy + _Albedo_ST.zw;
				float4 temp_output_3_0 = ( tex2D( _Albedo, uv_Albedo ) * _AlbedoColor );
				float4 temp_output_130_0 = ( tex2DNode129.r * ( ( ( 1.0 - clampResult128 ) * ( _StructureGlowIntens * ( _StructureColor * ( tex2D( _SructureGlowTexture, Offset112 ) + ( tex2D( _SructureGlowTexture, Offset140 ) * 0.6 ) ) ) ) ) * temp_output_3_0 ) );
				float4 temp_output_109_0 = ( temp_output_130_0 + temp_output_3_0 );
				float3 tanNormal153 = tex2DNode13;
				float fresnelNdotV153 = dot( float3(dot(tanToWorld0,tanNormal153), dot(tanToWorld1,tanNormal153), dot(tanToWorld2,tanNormal153)), ase_worldViewDir );
				float fresnelNode153 = ( _RimBias + _RimIntens * pow( 1.0 - fresnelNdotV153, _RimPower ) );
				float clampResult161 = clamp( fresnelNode153 , 0.0 , 1.0 );
				float lerpResult165 = lerp( 0.0 , ( 1.0 - clampResult161 ) , tex2DNode129.r);
				float4 lerpResult167 = lerp( temp_output_109_0 , ( _RimColor * temp_output_109_0 ) , lerpResult165);
				
				
				float3 Albedo = lerpResult167.rgb;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				half4 color = half4( Albedo, Alpha );

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}
		
	}
	CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=18000
0;0;1920;1019;-295.0233;1121.751;1.257903;True;True
Node;AmplifyShaderEditor.RangedFloatNode;142;-1504.767,-1299.752;Float;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;False;0;0.2;0.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-1582.161,-982.4522;Float;False;Property;_HeightMultiplayer;HeightMultiplayer;8;0;Create;True;0;0;False;0;0;0.36;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;148;-1283.286,-767.2541;Float;False;Constant;_Float2;Float 2;7;0;Create;True;0;0;False;0;2;0.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;134;-1699.972,-1218.07;Inherit;True;Property;_InnerHeightMap;InnerHeightMap;9;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;132;-1563.871,-1455.356;Float;False;Property;_InnerStructMapTilling;InnerStructMapTilling;3;0;Create;True;0;0;False;0;0;1.82;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-1356.305,-900.303;Float;False;Property;_InnerStructureDepth;InnerStructureDepth;7;0;Create;True;0;0;False;0;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;110;-753.5517,-814.7928;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;137;-947.5649,-1064.132;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;113;-1216.686,-1187.616;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;147;-997.4015,-892.9169;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;151;-1226.738,-1343.735;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;140;-383.6507,-965.1729;Inherit;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;150;1.620084,-776.6782;Float;False;Constant;_Float3;Float 3;7;0;Create;True;0;0;False;0;0.6;0.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;112;-379.5427,-1187.55;Inherit;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-1536.795,-552.9112;Float;False;Property;_NormalMapDepth;NormalMapDepth;27;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;139;-121.3286,-988.7354;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Instance;107;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;121;-850.6812,-1340.82;Float;False;Property;_FresnelPower;FresnelPower;5;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;107;-106.884,-1189.663;Inherit;True;Property;_SructureGlowTexture;SructureGlowTexture;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;122;-880.1086,-1601.02;Float;False;Property;_FresnelScale;FresnelScale;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;205.8227,-957.3193;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;13;-1240.977,-475.8791;Inherit;True;Property;_NormalMap;NormalMap;19;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;119;-464.5405,-1715.647;Inherit;False;Standard;TangentNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;114;-259.6114,-1379.112;Float;False;Property;_StructureColor;StructureColor;2;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;145;365.2234,-1072.941;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;118;-1.466029,-1444.989;Float;False;Property;_StructureGlowIntens;StructureGlowIntens;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;346.5651,-1231.943;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;128;-201.2771,-1703.243;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-456.4226,-468.3278;Float;False;Property;_AlbedoColor;AlbedoColor;11;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;123;42.98315,-1724.925;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-485.1377,-666.1189;Inherit;True;Property;_Albedo;Albedo;10;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;269.934,-1393.116;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;154;1277.483,-1000.66;Float;False;Property;_RimPower;RimPower;16;0;Create;True;0;0;False;0;1;0.17;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;160;1276.4,-907.2811;Float;False;Property;_RimBias;RimBias;15;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;155;1290.53,-1084.318;Float;False;Property;_RimIntens;RimIntens;17;0;Create;True;0;0;False;0;10;0.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;90.86964,-651.82;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;461.6142,-1630.448;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;153;1493.051,-1101.979;Inherit;False;Standard;TangentNormal;ViewDir;True;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;649.7714,-1469.665;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;129;558.0709,-1154.99;Inherit;True;Property;_InnerGlowMask;InnerGlowMask;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;130;909.2211,-1094.56;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;161;1722.956,-1064.519;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;166;1562.912,-895.9582;Float;False;Constant;_Float4;Float 4;29;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;109;823.4951,-777.6929;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;157;924.3415,-524.8787;Float;False;Property;_RimColor;RimColor;18;0;Create;True;0;0;False;0;1,1,1,0;0.5283019,0.5283019,0.5283019,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;162;1890.257,-1062.002;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;1206.788,-532.4262;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;165;1710.603,-824.2581;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LinearToGammaNode;103;-1611.315,288.9816;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-644.9746,-14.00033;Float;False;Property;_Metallic;Metallic;26;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;93;-879.5681,-29.05231;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-461.2012,333.9779;Float;False;Property;_Snoothness;Snoothness;25;0;Create;True;0;0;False;0;1;0.86;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;1158.789,-840.7527;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;764.2686,-562.4058;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;167;1686.188,-376.4447;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-293.0748,8.706559;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-196.8749,160.8066;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;152;1382.672,-723.1528;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;11;-515.8754,163.1064;Float;False;Property;_SmoothRough;Smooth/Rough;22;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-1387.871,-249.1329;Float;False;Property;_MetalicBrightnes;MetalicBrightnes;28;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;12;-750.9462,311.9731;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-1389.108,-135.8561;Float;False;Constant;_Float0;Float 0;21;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;33;-483.3045,-288.8951;Inherit;True;Property;_EmissionMap;EmissionMap;12;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-1775.516,-38.90791;Inherit;True;Property;_MetallicMap;MetallicMap;24;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-1961.9,260.7534;Inherit;True;Property;_SmoothnessMap;SmoothnessMap;23;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;2;-1130.743,191.3664;Float;False;Property;_SmoothFromMapSwitch;SmoothFromMapSwitch;20;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LinearToGammaNode;105;-1418.085,18.75522;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;104;-1383.809,277.0616;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;38;365.4774,-644.0977;Float;False;Property;_EmissionMultiplayer;EmissionMultiplayer;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;106;-1207.845,1.661224;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ToggleSwitchNode;32;438.5262,-378.484;Float;False;Property;_EmissionSwitch;EmissionSwitch;21;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;36;1012.445,-1561.341;Float;False;Property;_EmissionColor;EmissionColor;13;0;Create;True;0;0;False;0;0,0,0,0;0.7169812,0.7169812,0.7169812,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;169.5569,-437.1342;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;172;1165.502,-341.0357;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;168;1165.502,-341.0357;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;169;1165.502,-341.0357;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;2;ASE/ASE_StandartInnerGlow;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;14;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;14;Workflow;1;Surface;0;  Refraction Model;0;  Blend;0;Two Sided;1;Cast Shadows;1;Receive Shadows;1;GPU Instancing;1;LOD CrossFade;1;Built-in Fog;1;Meta Pass;1;Override Baked GI;0;Extra Pre Pass;0;Vertex Position,InvertActionOnDeselection;1;0;6;False;True;True;True;True;True;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;170;1165.502,-341.0357;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;171;1165.502,-341.0357;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;173;1165.502,-341.0357;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;True;True;True;True;True;0;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=Universal2D;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
WireConnection;137;0;134;1
WireConnection;137;1;138;0
WireConnection;113;0;132;0
WireConnection;113;1;142;0
WireConnection;147;0;111;0
WireConnection;147;1;148;0
WireConnection;151;0;132;0
WireConnection;140;0;113;0
WireConnection;140;1;137;0
WireConnection;140;2;147;0
WireConnection;140;3;110;0
WireConnection;112;0;151;0
WireConnection;112;1;137;0
WireConnection;112;2;111;0
WireConnection;112;3;110;0
WireConnection;139;1;140;0
WireConnection;107;1;112;0
WireConnection;149;0;139;0
WireConnection;149;1;150;0
WireConnection;13;5;66;0
WireConnection;119;0;13;0
WireConnection;119;4;110;0
WireConnection;119;2;122;0
WireConnection;119;3;121;0
WireConnection;145;0;107;0
WireConnection;145;1;149;0
WireConnection;115;0;114;0
WireConnection;115;1;145;0
WireConnection;128;0;119;0
WireConnection;123;0;128;0
WireConnection;117;0;118;0
WireConnection;117;1;115;0
WireConnection;3;0;1;0
WireConnection;3;1;4;0
WireConnection;127;0;123;0
WireConnection;127;1;117;0
WireConnection;153;0;13;0
WireConnection;153;4;110;0
WireConnection;153;1;160;0
WireConnection;153;2;155;0
WireConnection;153;3;154;0
WireConnection;116;0;127;0
WireConnection;116;1;3;0
WireConnection;130;0;129;1
WireConnection;130;1;116;0
WireConnection;161;0;153;0
WireConnection;109;0;130;0
WireConnection;109;1;3;0
WireConnection;162;0;161;0
WireConnection;158;0;157;0
WireConnection;158;1;109;0
WireConnection;165;0;166;0
WireConnection;165;1;162;0
WireConnection;165;2;129;1
WireConnection;103;0;6;0
WireConnection;93;0;106;0
WireConnection;93;1;97;0
WireConnection;93;2;95;0
WireConnection;37;0;36;0
WireConnection;37;1;130;0
WireConnection;39;0;38;0
WireConnection;39;1;32;0
WireConnection;167;0;109;0
WireConnection;167;1;158;0
WireConnection;167;2;165;0
WireConnection;7;0;8;0
WireConnection;7;1;93;0
WireConnection;10;0;11;0
WireConnection;10;1;9;0
WireConnection;152;0;37;0
WireConnection;152;1;39;0
WireConnection;11;0;2;0
WireConnection;11;1;12;0
WireConnection;12;0;2;0
WireConnection;2;0;5;4
WireConnection;2;1;104;2
WireConnection;105;0;5;0
WireConnection;104;0;103;0
WireConnection;106;0;105;0
WireConnection;32;0;33;0
WireConnection;32;1;34;0
WireConnection;34;0;3;0
WireConnection;34;1;33;4
WireConnection;169;0;167;0
WireConnection;169;1;13;0
WireConnection;169;2;152;0
WireConnection;169;3;7;0
WireConnection;169;4;10;0
ASEEND*/
//CHKSM=9C873B3E6CA437CCF07ED622C57805A6F044B4B2