/*
 * %FFILE%
 *
 * Copyright (C) %YEAR% %USER% <%MAIL%>
 *
 * Distributed under terms of the %LICENSE% license.
 */

fn main() {
    println!("Hello, World!");
    %HERE%
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test() {
    }
}
