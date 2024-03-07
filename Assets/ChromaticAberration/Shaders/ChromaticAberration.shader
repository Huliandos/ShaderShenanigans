Shader "_CameraShaders/ChromaticAberration"
{
    Properties
    {
        [HideInInspector] _MainTex ("Albedo (RGB)", 2D) = "white" {}
        [ShowAsVector2] _RedOffset ("Red offset", Vector) = (0, 0, 0, 0)
        [ShowAsVector2] _GreenOffset ("Green offset", Vector) = (0, 0, 0, 0)
        [ShowAsVector2] _BlueOffset ("Blue offset", Vector) = (0, 0, 0, 0)
        //Chromatic aberration tends to appear stronger towards the edges of camera lenses
        [MaterialToggle] _ConsiderDistanceToMiddle("Consider distance to middle", Float) = 0 
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
            float2 _RedOffset;
            float2 _GreenOffset;
            float2 _BlueOffset;
            float _ConsiderDistanceToMiddle;

            float4 frag (v2f_img input) : COLOR
            {
                float distFromCenter = lerp(1.0, distance(input.uv.xy, float2(.5, .5)), _ConsiderDistanceToMiddle);
                
                float2 redUV = input.uv + _RedOffset * distFromCenter;
                float2 greenUV = input.uv + _GreenOffset * distFromCenter;
                float2 blueUV = input.uv + _BlueOffset * distFromCenter;
                
                float4 color;
    
                color.r = tex2D(_MainTex, redUV).r;
                color.g = tex2D(_MainTex, greenUV).g;
                color.b = tex2D(_MainTex, blueUV).b;
                color.a = tex2D(_MainTex, input.uv).a;
                
                return color;
}
            ENDCG
        }
    }
}
