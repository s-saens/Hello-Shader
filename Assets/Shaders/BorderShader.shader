Shader "Custom/UVTest"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "" {}
        _MainColor ("Color", Color) = (1, 1, 1, 1)
        _BorderColor ("Border Color", Color) = (0, 0, 0, 1)
        _BorderThickness ("Border Thickness", Range(0, 0.5)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard

        sampler2D _MainTex;
        fixed4 _MainColor;
        fixed4 _BorderColor;
        fixed _BorderThickness;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            if (    IN.uv_MainTex.y > 1-_BorderThickness    ||
                    IN.uv_MainTex.y < _BorderThickness      ||
                    IN.uv_MainTex.x > 1-_BorderThickness    ||
                    IN.uv_MainTex.x < _BorderThickness      )
            {
                o.Albedo = _BorderColor;
            }
            else
            {
                o.Albedo = _MainColor;
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}
