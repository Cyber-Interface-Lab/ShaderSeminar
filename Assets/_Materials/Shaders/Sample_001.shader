// The name of shader (!= file name) is used when you set a shader to a material.
Shader "Custom/Sample_001"
{
    // Parameters in "Properties" appear in the inspector view and can be modified by your operation and scripts.
    Properties
    {
        // PARAMETER_NAME ("INSPECTOR_LABEL", TYPE) = DEFAULT_VALUE { OPTIONS }
        _MainTex ("Texture", 2D) = "white" {}
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
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

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

            // This "_MainTex" is equal to the "_MainTex" in "Properties".
            sampler2D _MainTex;
            // "TEXTURE_NAME_ST" means tilling and offset values in inspector view.
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

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
