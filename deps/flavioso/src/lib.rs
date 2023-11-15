use flavio::
{
    constitutive::
    {
        ConstitutiveModel,
        hyperelastic::
        {
            NeoHookeanModel
        }
    },
    math::
    {
        TensorRank2Trait,
        special::
        {
            inverse_langevin as flavio_inverse_langevin,
            langevin as flavio_langevin
        }
    },
    mechanics::
    {
        CauchyStress,
        DeformationGradient,
        Scalar
    }
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

#[no_mangle]
pub extern fn neo_hookean(
    bulk_modulus: Scalar, shear_modulus: Scalar,
    f_11: Scalar, f_12: Scalar, f_13: Scalar,
    f_21: Scalar, f_22: Scalar, f_23: Scalar,
    f_31: Scalar, f_32: Scalar, f_33: Scalar
) -> (Scalar, Scalar, Scalar,
      Scalar, Scalar, Scalar,
      Scalar, Scalar, Scalar)
{
    let cauchy_stress = NeoHookeanModel::new(
        &[bulk_modulus, shear_modulus]
    ).calculate_cauchy_stress(
        &DeformationGradient::new([
            [f_11, f_12, f_13],
            [f_21, f_22, f_23],
            [f_31, f_32, f_33]
        ])
    );
    (cauchy_stress[0][0], cauchy_stress[0][1], cauchy_stress[0][2],
     cauchy_stress[1][0], cauchy_stress[1][1], cauchy_stress[1][2],
     cauchy_stress[2][0], cauchy_stress[2][1], cauchy_stress[2][2])
}
