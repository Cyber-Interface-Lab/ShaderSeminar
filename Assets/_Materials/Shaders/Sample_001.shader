// The name of shader (!= file name) is used when you set a shader to a material.
Shader "Custom/Sample_001"
{
    // Parameters in "Properties" appear in the inspector view and can be modified by your operation and C# scripts.
    Properties
    {
        // PROPERTY_NAME ("INSPECTOR_LABEL", TYPE) = DEFAULT_VALUE { OPTIONS }
        _MainTex ("Texture", 2D) = "white" {}

        /*
        // These are other samples.
        _Float ("Float", float) = 0.1
        _Int ("Int", int) = 5
        _Range ("Range", Range(0.0, 1.0)) = 0.3
        */
    }

    // Shaders determine the color in each pixel as "SubShader" instructs.
    SubShader
    {
        // Settings of the shader.
        Tags { "RenderType"="Opaque" }

        // Level of Detail.
        LOD 100

        Pass
        {
            // charms!!!
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog // make fog work
            #include "UnityCG.cginc"

            // Parameters to vertex shader.
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            // Parameters delivered from vertex shader (v) to fragment shader (f)
            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            // Parameters from "Properties".
            sampler2D _MainTex; // This "_MainTex" is equal to the "_MainTex" in "Properties".
            float4 _MainTex_ST; // "TEXTURE_NAME_ST" means tilling and offset values of _MainTex in inspector view.

            // Vertex shader.
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            // Fragment shader.
            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }

    FallBack "Standard"
}
