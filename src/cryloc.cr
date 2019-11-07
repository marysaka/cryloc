require "./cryloc/**"

fun calloc(nmeb : SizeT, size : SizeT) : Void*
  # puts("CALLOC")
  res = malloc(nmeb * size)
  if res.address != 0
    cryloc_memset(res.as(UInt8*), 0, (nmeb * size).to_u64)
  end
  res
end

fun malloc(size : SizeT) : Void*
  Cryloc.allocate(size)
end

fun free(ptr : Void*)
  Cryloc.release(ptr)
end

fun realloc(ptr : Void*, size : SizeT) : Void*
  Cryloc.re_allocate(ptr, size)
end

fun memalign(alignment : SizeT, size : SizeT) : Void*
  Cryloc.allocate_aligned(alignment, size)
end
