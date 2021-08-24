Shader "Custom/FireShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
        _SubTex ("SubTexture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }

        CGPROGRAM
        #pragma surface surf Standard alpha:fade

        sampler2D _MainTex;
        sampler2D _SubTex;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_SubTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D(_SubTex, float2(IN.uv_MainTex.x, IN.uv_MainTex.y - _Time.y));
            o.Emission = c.rgb + d.rgb;
            o.Alpha = c.a * d.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
