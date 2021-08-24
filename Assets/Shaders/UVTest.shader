Shader "Custom/UVTest"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Velocity ("Flow Speed", float) = 2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard

        sampler2D _MainTex;
        float _Velocity;

        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, fmod((IN.uv_MainTex * _Time.y * _Velocity), 3));
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
