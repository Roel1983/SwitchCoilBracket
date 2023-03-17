$fn = 64;
nozzle = 0.4;
BIAS   = 0.1;

SwitchCoilBracket();

module SwitchCoilBracket(
    w1 = 10,
    w2 = 15,
    l  = 35,
    l1 = 8,
    l2 = 20 + 4,
    h  = 10,
    h1 = 2,
    h2 = 1,
    d1 = 10,
    d2 =  4,
    d3 =  8.5,
    a  =  4,
    b  =  5,
    c  =  3.0,
    d  =  2.0,
    e  =  2.0,
    f  =  1.0
) {
    difference() {
        Base();
        Trench();
        ZipTieHoles();
    }
    Foot();

    module Base() {
        linear_extrude(h, convexity=2) {
            square([
                w1,
                l
            ], true);
            mirror_copy([0, 1]) {
                translate([
                    0,
                    (l - l1) / 2
                ]) square([
                    w2,
                    l1
                ], true);
            }
        }
    }

    module Trench() {
        translate([0, 0, h]) {
            rotate(90, [1, 0, 0]) {
                linear_extrude(
                    l + BIAS,
                    center    = true,
                    convexity = 2
                ) {
                    hull() {
                        translate([
                            0,
                            1
                        ])square([
                            w2 - 4 * nozzle,
                            2
                        ], true);
                        translate([0, f]) {
                            circle(d=d1);
                        }
                    }
                }
            }
        }
    }
    module Foot() {
        difference() {
            linear_extrude(h1, convexity=2) {
                difference() {
                    hull() {
                        square([
                            w2,
                            l
                        ], true);
                        mirror_copy([1, 0]) {
                            t() circle(d= d2 + a);
                        }
                    }
                    mirror_copy([1, 0]) {
                        hull() {
                            t() circle(d= d2);
                        }
                    }
                }
            }
            translate([0, 0, h2]) linear_extrude(h1) {
                mirror_copy([1, 0]) {
                    hull() {
                        t() circle(d= d3);
                    }
                }
            } 
        }
        
        module t() {
            mirror_copy([0, 1]) {
                translate([
                    l2 / 2,
                    b / 2 
                ]) {
                    children();
                }
            }
        }
    }

    module ZipTieHoles() {
        mirror_copy([0,1]) {
            translate([0, (l / 2 - l1) * 2/3, h]) {
                rotate(90, [1, 0, 0]) {
                    linear_extrude(
                        c,
                        center = true
                    ) {
                        difference() {
                            circle(d=d1 + e + d);
                            circle(d=d1 + e);
                        }
                    }
                }
            }
        }
    }
}

module mirror_copy(vec) {
    children();
    mirror(vec) children();
}
