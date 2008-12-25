import java.util.*;

class AutoRule {
  AutoRule next;
  int h, w, f;
  String tex, type;

  String retexture(String t, int sh, int sw, int sf) {
    if(type.equals(t)) {
      if(h==0 || h==sh || (h<0 && sh>(-h))) {
        if(w==0 || w==sw || (w<0 && sw>(-w))) {
          if(f==0 || f==sf || (f<0 && sf>(-f))) {
            return tex;
          };
        };
      };
    };
    if(next!=null) return next.retexture(t, sh, sw, sf);
    if(t.equals("C") || t.equals("F")) return "SLIME13";    // just incase
    return "METAL";
  }
}

