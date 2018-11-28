# OrdinalizeFull

[![Build Status](https://travis-ci.org/infertux/ordinalize_full.svg?branch=master)](https://travis-ci.org/infertux/ordinalize_full)
[![Gem Version](https://badge.fury.io/rb/ordinalize_full.svg)](https://badge.fury.io/rb/ordinalize_full)

Like Rails' [ordinalize](http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-ordinalize) method but with the ability to return the ordinal string spelled out in full words such as _"first"_, _"second"_, _"third"_.

Features:

- i18n support
- doesn't monkey-patch
- easy to integrate with Rails but doesn't require Rails
- less than 50 lines of code

## Usage

### Monkey-patching `Integer` (like Rails does)

```ruby
require "ordinalize_full/integer"

42.ordinalize_in_full #=> "forty second"
42.ordinalize_full #=> "forty second"
42.ordinalize(in_full: true) #=> "forty second"
42.ordinalize #=> "42nd"

I18n.locale = :fr
42.ordinalize_in_full #=> "quarante-deuxième"
42.ordinalize #=> "42ème"

I18n.locale = :es
14.ordinalize_in_full(gender: :feminine, plurality: :plural) #=> decimocuartas
1.ordinalize_in_full #=> primer // default masculine, singular
22.ordinalize_in_full(gender: :feminine) #=> vigésima segunda // default singular
1.ordinalize #=> 1.ᵉʳ
55.ordinalize #=> 55.ᵒ
```

### Without monkey-patching

```ruby
require "ordinalize_full"

42.ordinalize_in_full #=> NoMethodError: undefined method `ordinalize_in_full' for 42:Fixnum

class MyIntegerLikeClass; include OrdinalizeFull; def to_s; "42"; end; end #=> :to_s
MyIntegerLikeClass.new.ordinalize_in_full #=> "forty second"
```

## Limitations

- only works up to 100 (for now)
- locales only available in English, French, Italian, Spanish, and Dutch (pull requests welcome!)

