// Welcome! This is a Shadertoy-style shader.
// mainImage runs once for each pixel, every frame.
// Try changing a number, then watch the preview on the right.

float g = 0.5;

vec2 calcForces(vec2 pos, vec2 vel) {
    vec2 body = vec2(0.5,0.5);
    float body_mass = 2.0;

    return pos;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Pixel position, from 0 to 1 across the screen.
    vec2 uv = fragCoord / iResolution.xy;

    // A colour that shifts over time.
    vec3 col = 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0.0, 2.0, 4.0));

    // A soft circle in the middle that follows the mouse while you hold a button.
    vec2 centre = iMouse.z > 0.0 ? iMouse.xy : 0.5 * iResolution.xy;
    float d = length(fragCoord - centre) / iResolution.y;
    col *= smoothstep(0.35, 0.3, d) * 0.5 + 0.5;

    fragColor = vec4(col, 1.0);
}
