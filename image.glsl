// Welcome! This is a Shadertoy-style shader.
// mainImage runs once for each pixel, every frame.
// Try changing a number, then watch the preview on the right.

float g = 0.5;

void calcForces(inout vec2 pos,inout vec2 vel, float time) {
    vec2 body = vec2(0.5,0.4);
    float body_mass = 2.0;

    float d = distance(pos,body);

    float f = g * body_mass / d / d;

    vel += f * time;
    pos += vel * time;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    
    int steps = 5;

    vec2 pos = fragCoord / vec2(iResolution.x,iResolution.x);;
    vec2 vel = vec2(0.0,0.0);
    for (int i = 0; i < steps; i++) {

        calcForces(pos,vel,0.1 / (float)steps);
    }

    vec3 col = vec3(pos.x,pos.y,1.0);

    fragColor = vec4(col, 1.0);
}
