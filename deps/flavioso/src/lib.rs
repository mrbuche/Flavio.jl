use flavio::
{
    math::special::
    {
        inverse_langevin as flavio_inverse_langevin,
        langevin as flavio_langevin
    },
    mechanics::Scalar
};

#[no_mangle]
pub extern fn inverse_langevin(y: Scalar) -> Scalar
{
    flavio_inverse_langevin(y)
}

#[no_mangle]
pub extern fn langevin(x: Scalar) -> Scalar
{
    flavio_langevin(x)
}
