$fn = 64;
nozzle = 0.4;
BIAS   = 0.1;

SwitchCoilBracket();

module SwitchCoilBracket(
    w1 = 10,
    w2 = 15,
    l  = 35,
    l1 = 8,
    h  = 10,
    h1 = 2,
    d1 = 10,
    d2 =  4,
    a  =  4,
    b  =  5,
    c  =  3.0,
    d  =  2.0,
    e  =  2.0
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
                        circle(d=d1);
                    }
                }
            }
        }
    }
    module Foot() {
        difference() {
            linear_extrude(h1) {
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
            
        }
        
        module t() {
            mirror_copy([0, 1]) {
                translate([
                    w1 / 2 + a,
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