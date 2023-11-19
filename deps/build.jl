cd("flavioso")
run(`cargo clippy -- -D warnings`)
run(`cargo build --release`)
