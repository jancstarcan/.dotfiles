precision highp float;

varying vec2 f_src_pos;

uniform sampler2D u_texture;

const float threshold = 0.01;
const vec3 pink = vec3(0.894, 0.275, 0.769); // #e446c4
const vec3 orange = vec3(0.925, 0.431, 0.306); // #ec6e4e
const vec3 green = vec3(0.275, 0.808, 0.400); // #46ce66
const vec3 brown = vec3(0.800, 0.424, 0.275); // #cc6c46
const vec3 gray = vec3(0.275, 0.298, 0.275); // #454c46

void main() {
    vec4 color = texture2D(u_texture, f_src_pos);

    bool is_pink = all(lessThan(abs(color.rgb - pink), vec3(threshold)));
    bool is_orange = all(lessThan(abs(color.rgb - orange), vec3(threshold)));
    bool is_green = all(lessThan(abs(color.rgb - green), vec3(threshold)));
    bool is_brown = all(lessThan(abs(color.rgb - brown), vec3(threshold)));
    bool is_gray = all(lessThan(abs(color.rgb - gray), vec3(threshold)));

    if (is_pink || is_orange || is_green || is_brown || is_gray) {
        gl_FragColor = color;
    } else {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    }
}
