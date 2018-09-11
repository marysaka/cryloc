# cryloc

A platform independent memory allocator in Crystal.

For now the implementation, is based on a free list but more implementations will come in the future.

## Demo

An implementation is provided for x86_64-*-linux-gnu. It's design as a malloc(3) replacement and provide a static and dynamic shared library.

See [here](https://github.com/Thog/cryloc/blob/master/src/linux_prelude.cr) for the implementation.

To build it, uses:
```
make
```

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  cryloc:
    github: Thog/cryloc
```

## Usage

```crystal
require "cryloc"
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/Thog/cryloc/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Thog](https://github.com/Thog) Thog - creator, maintainer
