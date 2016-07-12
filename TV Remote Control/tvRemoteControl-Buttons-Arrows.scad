use <tvRemoteControl-Buttons.scad>;


module arrows()
{
    button(0,0) letter("ok");
    button(-4,0) rotate(180) arrow();
    button(4,0) arrow();
    button(0,4) rotate(90) arrow();
    button(0,-4) rotate(-90) arrow();
    
    hull() {
        base(4,0);
        base(-4,0);
    }
    hull() {
        base(0,4);
        base(0,-4);
    }
}

arrows();
