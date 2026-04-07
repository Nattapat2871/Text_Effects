vec2 currentOffset = vec2(0.0);

void setOffset(float x, float y) {
    currentOffset = vec2(x, y);
}

void applyOffset(inout vec4 vertex) {
    vec4 clip = ProjMat * ModelViewMat * vertex;

    bool isGUI = ProjMat[3][3] != 0.0;
    if (isGUI) {
        vertex.xy += currentOffset;
        clip = ProjMat * ModelViewMat * vertex;
    } else {
        clip.x += currentOffset.x * (20.0 / ScreenSize.x) * clip.w;
        clip.y -= currentOffset.y * (20.0 / ScreenSize.y) * clip.w;
    }

    vertex = inverse(ProjMat * ModelViewMat) * clip;
}