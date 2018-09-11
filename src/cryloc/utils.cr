{% if flag?(:bits64) %}
alias SizeT = UInt64
alias SSizeT = Int64

struct Int
  def to_ssize
    self.to_u64
  end
end
{% else %}
alias SizeT = UInt32
alias SSizeT = Int32

struct Int
  def to_ssize
    self.to_u32
  end
end

{% end %}

lib LibC
  fun sbrk(increment : SizeT) : Void*
end

macro cryloc_max(a, b)
  {{a}} >= {{b}} ? {{a}} : {{b}}
end

macro cryloc_align(size, align)
  (({{size}} + {{align}} - 1) & ~({{align}} - 1))
end

@[AlwaysInline]
def sbrk(increment : SizeT) : Void*
  {% if flag?(:cryloc_external_sbrk) %}
    LibC.sbrk(increment)
  {% else %}
    cryloc_sbrk(increment)
  {% end %}
end

def cryloc_memcpy(dest : UInt8*, src : UInt8*, n : UInt64)
  i = 0u64
  until i == n
    Pointer(UInt8).new(dest.address + i).value = Pointer(UInt8).new(src.address + i).value
    i += 1
  end
  dest
end

def cryloc_memset(s : UInt8*, c : Int32, n : UInt64) : UInt8*
  i = 0u64
  until i == n
    Pointer(UInt8).new(s.address + i).value = c.to_u8
    i += 1
  end
  s
end
