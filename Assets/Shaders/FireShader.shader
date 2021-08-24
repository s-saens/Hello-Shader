Shader "Custom/FireShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
        _SubTex ("SubTexture", 2D) = "gray" {}
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
            fixed4 d = tex2D(_SubTex, float2(IN.uv_SubTex.x, IN.uv_SubTex.y - _Time.y));
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex + d.r - 0.07);
            
            o.Emission = c.rgb;
            o.Alpha = c.a;

            if(IN.uv_MainTex.y < 0.05 || IN.uv_MainTex.y > 0.95 || IN.uv_MainTex.x < 0.05 || IN.uv_MainTex.x > 0.95)
            {
                o.Emission = 0;
                o.Alpha = 1;
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}
