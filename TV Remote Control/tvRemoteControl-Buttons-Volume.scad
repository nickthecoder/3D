use <tvRemoteControl-Buttons.scad>;


module volume()
{    
    button(0,6) plus();
    button(0,0) minus();
    
    hull() {
        base(0,6);
        base(0,0);
    }
}

volume();

