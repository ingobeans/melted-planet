float g = 0.5;

void calcForces(vec2 pos,vec2 vel, inout vec2 forces, float time, vec2 body) {
    //pos.y = sin(pos.y+pos.x/6.0);
    pos.y = sin(pos.y+sin(pos.x)/6.0 );

    float body_mass = 100.0;

    float d = distance(pos,body);

    float f = g * body_mass / d / d;
    vec2 delta = (body-pos)/d;

    forces += f*delta;
}
void applyForces(inout vec2 pos,inout vec2 vel, inout vec2 forces, float time) {
    vel += forces * time;
    pos += vel * time;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    
    int steps = 250;

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
    float c = 

    fragColor = vec4(col, 1.0);
}
