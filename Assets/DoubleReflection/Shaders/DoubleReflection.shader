Shader "_CameraShaders/DoubleReflection"
{
    Properties
    {
        [HideInInspector] _MainTex ("Albedo (RGB)", 2D) = "white" {}
        [ShowAsVector2] _Offset ("Offset", Vector) = (0, 0, 0, 0)
        _ReflectionColor ("Reflection color", Color) = (0, 0, 0, 0)
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
            float2 _Offset;
            float4 _ReflectionColor;

            float4 frag (v2f_img input) : COLOR
            {
                float2 offsetUV = input.uv + _Offset;
                
                float4 base = tex2D(_MainTex, input.uv);
                
                float4 offsetBase = tex2D(_MainTex, offsetUV);
                offsetBase *= _ReflectionColor;
    
                return base + offsetBase;
            }
            ENDCG
        }
    }
}
