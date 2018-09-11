require "primitives"

struct Int

  # needed by SimpleAllocator
  def ~
    self ^ -1
  end
end

# We only support x86_64-<anything>-linux-gnu for this example.
{% if flag?(:x86_64) && flag?(:linux) && flag?(:gnu) %}

# not the best definitions but it does the trick.
alias PthreadMutexT = StaticArray(UInt8, 0x28)
alias PthreadMutexattrT = Int32

{% end %}

# This provide the locking implementation used if cryloc_lock flag is set.
{% if flag?(:cryloc_lock) %}

lib LibC
  fun pthread_mutex_init(x0 : PthreadMutexT*, x1 : PthreadMutexattrT*) : Int32
  fun pthread_mutex_lock(x0 : PthreadMutexT*) : Int32
  fun pthread_mutex_unlock(x0 : PthreadMutexT*) : Int32
  fun abort : NoReturn
end

struct Cryloc::Lock
  @@need_init = 1i32
  @@mutex = uninitialized PthreadMutexT

  def self.init?
    @@need_init == 0
  end

  def self.init_lock
    if LibC.pthread_mutex_init(pointerof(@@mutex), nil) != 0
      LibC.abort
    end
    @@need_init = 0i32
  end

  def self.enter
    LibC.pthread_mutex_lock(pointerof(@@mutex))
  end

  def self.leave
    LibC.pthread_mutex_unlock(pointerof(@@mutex))
  end
end

{% end %}

# for crystal linking, not relevant for an implementation.
fun main : Void
end
