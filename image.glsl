// random bullshit go: the shader
//


// messed up gravity formula because yes
float g = 0.5;
void calcForces(vec2 pos,vec2 vel, inout vec2 forces, float time, vec2 body) {
    // to make it less symmetrical and boring
    pos.y = sin(pos.y+sin(pos.x)/6.0 );

    float body_mass = 100.0;

    float d = distance(pos,body) * 0.3;
    if (d < 0.0) {
        d = 100.0;
    }

    float f = g * body_mass / d ;
    vec2 delta = (body-pos)/d;

    forces += f*delta;
}
void applyForces(inout vec2 pos,inout vec2 vel, inout vec2 forces, float time) {
    vel += forces * time;
    pos += vel * time;
}

float colorBand(float inputC, float steps) {
    return float(int(inputC * steps)) / steps;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    
    int steps = 5;

    vec2 pos = fragCoord / vec2(iResolution.x,iResolution.x);;
    vec2 vel = vec2(0.0,0.0);
    for (int i = 0; i < steps; i++) {
        vec2 forces = vec2(0.0,0.0);

        vec2 body = vec2(0.1, iResolution.y*0.1/iResolution.x);
        calcForces(pos,vel,forces,0.1 / float(steps), body);
        body = vec2(0.9, iResolution.y*0.9/iResolution.x);
        calcForces(pos,vel,forces,0.1 / float(steps), body);
        applyForces(pos,vel,forces,0.1 / float(steps));
    }

    vec3 col = vec3(pos.x,pos.y,1.0);
    float c = pos.x + pos.y;
    // cool color
    vec3 col1 = vec3(191.0/255.0,26.0/255.0,230.0/255.0);
    vec3 col2 = vec3(255.0/255.0,167.0/255.0,230.0/255.0);
    
    col = mix(col1,col2,c);

    // color banding maybe?

    fragColor = vec4(col, 1.0);
}
