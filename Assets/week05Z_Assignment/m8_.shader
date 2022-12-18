Shader "Custom/m8_"
{
    Properties
    {
        _MainTex1("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5

    }
        SubShader
        {
            Tags { "RenderType" = "Opaque" }

            CGPROGRAM
            #pragma surface surf Standard fullforwardshadows

            sampler2D _MainTex1;
            sampler2D _MainTex2;

            struct Input
            {
                float2 uv_MainTex1;
                float2 uv_MainTex2;
            };
            half _Glossiness;


            void surf(Input IN, inout SurfaceOutputStandard o)
            {
                fixed4 c = tex2D(_MainTex1, IN.uv_MainTex1);
                fixed4 d = tex2D(_MainTex2, IN.uv_MainTex2); // 알파 값이 있는 이미지
                //o.Albedo = c.rgb;
                //o.Albedo = lerp(c.rgb, d.rgb, _LerpRange);

                o.Albedo = lerp(c.rgb, d.rgb, d.a);
                //o.Albedo = lerp(c.rgb, d.rgb, 1-d.a);
                //o.Albedo = lerp(d.rgb, c.rgb, d.a);    
                o.Smoothness = _Glossiness;


                o.Alpha = c.a;
            }
            ENDCG
    }
    FallBack "Diffuse"
}
