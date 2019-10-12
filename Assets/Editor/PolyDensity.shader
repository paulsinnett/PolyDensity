Shader "Unlit/PolyDensity"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Highlight ("Highlight Colour", Color) = (1, 0, 0, 0.5)
        _Smallest ("Smallest", Float) = 0.001
        _Largest ("Largest", Float) = 0.1
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
            #pragma geometry geom

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 density : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Highlight;
            float _Smallest;
            float _Largest;

            v2f vert (appdata v)
            {
                v2f o;
                float4 pos = UnityObjectToClipPos(v.vertex);
                o.vertex = pos;
                o.uv = v.uv;
                float4 screen = pos * 0.5;
                float aspect = _ScreenParams.x / _ScreenParams.y;
                o.density.xy = 
                    (float2(screen.x * aspect, screen.y) + screen.w) / pos.w;

                o.density.zw = pos.zw;
                return o;
            }

            [maxvertexcount(3)]
            void geom(
                triangle v2f input[3],
                inout TriangleStream<v2f> OutputStream)
            {
                float2 ab = input[1].density.xy - input[0].density.xy;
                float2 cd = input[2].density.xy - input[0].density.xy;
                float area = sqrt(abs(ab.x * cd.y - cd.x * ab.y));
                float density = (area - _Smallest) / _Largest;

                v2f test = (v2f)0;
                for(int i = 0; i < 3; i++)
                {
                    test.vertex = input[i].vertex;
                    test.uv = input[i].uv;
                    test.density.z = saturate(1 - density);
                    OutputStream.Append(test);
                }
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return lerp(col, _Highlight, i.density.z * _Highlight.a);
            }
            ENDCG
        }
    }
}
