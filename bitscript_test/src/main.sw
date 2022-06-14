script;

use bitshifter::*;
use std::assert::assert;

fn main() -> bool {

    assert(turn_off_bit(MAX_BINARY_U64, 11) == 0b11111111_11111111_11111111_11111111_11111111_11111111_11110111_11111111);

    true
}
