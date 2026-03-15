function rectangle_intersects(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2) {
    // normalize coords so (left, top, right, bottom) is guaranteed
    var a_left   = min(ax1, ax2);
    var a_right  = max(ax1, ax2);
    var a_top    = min(ay1, ay2);
    var a_bottom = max(ay1, ay2);

    var b_left   = min(bx1, bx2);
    var b_right  = max(bx1, bx2);
    var b_top    = min(by1, by2);
    var b_bottom = max(by1, by2);

    return !(a_right < b_left || a_left > b_right || a_bottom < b_top || a_top > b_bottom);
};