/*
 * Copyright © 2001-2008 Wouter van Oortmerssen
 * Copyright © 2008-2016 Jonathan Dowland <jon@dow.land>
 *
 * Distributed under the terms of the GNU GPL Version 2
 * See file LICENSE.txt
 */

package org.redmars.wadc;
import java.util.*;

class Choice extends Exp {
  static long seed;
  static Random rnd = new Random();

  static void setSeed(int s) {
      seed = s;
      rnd.setSeed(s);
  }

  List<Exp> v = new ArrayList<>();

  void add(Exp e) {
    v.add(e);
  }

  Exp replace(Vector n, Vector r) {
    return (v.get(Math.abs(rnd.nextInt()) % v.size())).replace(n,r);
  }

  String show() {
    return "[choice]";
  }
}
