library swaybits;

// use core::num::*;

/// Set the nth bit of a bitmap to `0`.
pub fn turn_off_bit(bitmap: u64, n: u64) -> u64 {
    let mask = toggle_bit(u64::max(), n);
    bitmap & mask
}

/// Set the nth bit of a bitmap to `1`.
pub fn turn_on_bit(bitmap: u64, n: u64) -> u64 {
    let mask = toggle_bit(u64::min(), n);
    bitmap | mask
}

/// Flip the nth bit in a bitmap.
pub fn toggle_bit(bitmap: u64, n:  u64) -> u64 {
    let mask = single_bit_mask(n);
    bitmap ^ mask
}

/// Query a bitmat for the state of the nth bit.
pub fn query_bit(bitmap: u64, n: u64) -> u64 {
    let mask = single_bit_mask(n);
    (bitmap & mask) >> n
}

/// Set the nth bit of a bitmap to `value`
pub fn set_bit(bitmap: u64, n: u64, value: u64) -> u64 {
    if query_bit(bitmap, n) == value {
        bitmap
    } else {
        toggle_bit(bitmap, n)
    }
}

/// Get a bitmask of `n` ones.
pub fn multi_bit_mask(n: u64) -> u64 {
    (1 << n) - 1
}

/// Get a bitmask with a single `1` at the nth position.
pub fn single_bit_mask(n: u64) -> u64 {
    1 << (n)
}

#[test()]
fn test_single_bit_mask() {
    assert(single_bit_mask(0) == 0b1);
    assert(single_bit_mask(1) == 0b10);
}

#[test()]
fn test_multi_bit_mask() {
    assert(multi_bit_mask(11) == 0b11111111111);
}

#[test()]
fn test_turn_off_bit() {
    assert(turn_off_bit(u64::max(), 11) == 0b1111111111111111111111111111111111111111111111111111011111111111);
}

#[test()]
fn test_turn_on_bit() {
    assert(turn_on_bit(u64::min(), 11) == 0b100000000000);
}

#[test()]
fn test_toggle_bit() {
    let first = toggle_bit(u64::min(), 11);
    assert(first == 0b100000000000);
    let second = toggle_bit(first, 3);
    assert(second == 0b100000001000);
    let third = toggle_bit(second, 11);
    assert(third == 0b000000001000);
    assert(toggle_bit(third, 3) == 0);

}

#[test()]
fn test_query_bit() {
    let bitmap = 0b000100100010;
    assert(query_bit(bitmap, 0) == 0);
    assert(query_bit(bitmap, 1) == 1);
    assert(query_bit(bitmap, 5) == 1);
}

#[test()]
fn test_set_bit() {
    let mut bitmap = 0b10101;
    log(bitmap);
    bitmap = set_bit(bitmap, 0, 0);
    log(bitmap);
    bitmap = set_bit(bitmap, 1, 1);
    log(bitmap);
    bitmap = set_bit(bitmap, 2, 0);
    log(bitmap);
    bitmap = set_bit(bitmap, 3, 1);
    log(bitmap);
    bitmap = set_bit(bitmap, 4, 0);
    log(bitmap);
    assert(bitmap == 0b01010)
}