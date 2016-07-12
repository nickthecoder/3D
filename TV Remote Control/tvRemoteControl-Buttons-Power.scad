use <tvRemoteControl-Buttons.scad>;


module power()
{
    button(0,0) letter("x");
    button(15,0) letter("X");
    
    hull() {
        base(0,0);
        base(15,0);
    }
}

power();
