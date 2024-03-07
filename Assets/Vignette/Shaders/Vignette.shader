Shader "_CameraShaders/Vignette"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 1)
        [HideInInspector] _MainTex ("Texture", 2D) = "white" {}
        _Radius ("Vignette Radius", Range(0.0, 1.0)) = 1.0
        _Softness ("Vignette Softness", Range(0.0, 1.0)) = 0.5
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc" //required for v2f_img

            //Properties
            sampler2D _MainTex;
            float _Radius;
            float _Softness;
            float4 _Color;

            float4 frag (v2f_img input) : COLOR
            {
                //find distance from input pixel to middle of screen
                float distFromCenter = distance(input.uv.xy, float2(.5, .5));
                float vignette = smoothstep(_Radius, _Radius - _Softness, distFromCenter);
    
                float4 base = tex2D(_MainTex, input.uv);
                base = saturate(base * vignette);   
                base = base * _Color;
                return base;
            }
            ENDCG
        }
    }
}