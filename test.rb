#!ruby -Ks
# encoding: Windows-31J

class Numeric
  def roundup(d=0)
    x = 10**d
    if self > 0
      (self * x).ceil.quo(x)
    else
      (self * x).floor.quo(x)
    end
  end

  def rounddown(d=0)
    x = 10**d
    if self < 0
      (self * x).ceil.quo(x)
    else
      (self * x).floor.quo(x)
    end
  end

  def roundoff(d=0)
    x = 10**d
    if self < 0
      (self * x - 0.5).ceil.quo(x)
    else
      (self * x + 0.5).floor.quo(x)
    end
  end
end



x= 1.to_f
y=x/3
p y.roundoff(2).to_f
