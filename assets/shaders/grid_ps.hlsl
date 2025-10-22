struct PSInput
{
    float4 position : SV_POSITION;
    float3 worldPos : TEXCOORD0;
    float2 uv       : TEXCOORD1;
};

float4 psmain(PSInput input) : SV_TARGET
{
    // Scale controls how dense the grid lines are
    float scale = 1.0f;
    float2 coord = input.worldPos.xz * scale;

    // Create grid lines
    float gridLine = (abs(frac(coord.x) - 0.5f) < 0.02f ||
                  abs(frac(coord.y) - 0.5f) < 0.02f) ? 1.0f : 0.0f;

    // Base colors
    float3 gridColor = lerp(float3(0.1, 0.1, 0.1), float3(0.7, 0.7, 0.7), gridLine);
    float3 baseColor = float3(0.05, 0.05, 0.05);

    float3 finalColor = lerp(baseColor, gridColor, gridLine);

    // Make center lines (X=0 or Z=0) more visible
    if (abs(input.worldPos.x) < 0.1f)
        finalColor = float3(1.0, 0.1, 0.1); // X-axis red
    if (abs(input.worldPos.z) < 0.1f)
        finalColor = float3(0.1, 0.4, 1.0); // Z-axis blue

    return float4(finalColor, 1.0f);
}
