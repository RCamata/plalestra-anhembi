Shader "Unlit/shader_base"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _PositionX ("PositionX", Range(-1.0, 1.0)) = 0
        _PositionY ("PositionY", Range(-1.0, 1.0)) = 0
        _PositionZ ("PositionZ", Range(-1.0, 1.0)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float color : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;
            float _PositionX;
            float _PositionY;
            float _PositionZ;

            v2f vert (appdata v)
            {
                v2f o;

                v.vertex.x += _PositionX;
                v.vertex.y += _PositionY;
                v.vertex.z += _PositionZ;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
