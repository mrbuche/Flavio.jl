use flavio::
{
    constitutive::
    {
        ConstitutiveModel,
        solid::
        {
            elastic::
            {
                ElasticConstitutiveModel,
                AlmansiHamelModel
            },
            hyperelastic::
            {
                HyperelasticConstitutiveModel,
                ArrudaBoyceModel,
                FungModel,
                GentModel,
                MooneyRivlinModel,
                NeoHookeanModel,
                SaintVenantKirchoffModel
            }
        }
    },
    math::
    {
        TensorRank2Trait,
        TensorRank4Trait
    },
    mechanics::
    {
        DeformationGradient,
        Scalar
    }
};

#[no_mangle]
unsafe extern fn almansi_hamel_cauchy_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        AlmansiHamelModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_cauchy_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn almansi_hamel_cauchy_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        AlmansiHamelModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_cauchy_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn almansi_hamel_first_piola_kirchoff_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        AlmansiHamelModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_first_piola_kirchoff_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn almansi_hamel_first_piola_kirchoff_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        AlmansiHamelModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_first_piola_kirchoff_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn arruda_boyce_cauchy_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    number_of_links: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        ArrudaBoyceModel::new(
            &[bulk_modulus, shear_modulus, number_of_links]
        ).calculate_cauchy_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn arruda_boyce_cauchy_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    number_of_links: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        ArrudaBoyceModel::new(
            &[bulk_modulus, shear_modulus, number_of_links]
        ).calculate_cauchy_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn arruda_boyce_first_piola_kirchoff_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    number_of_links: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        ArrudaBoyceModel::new(
            &[bulk_modulus, shear_modulus, number_of_links]
        ).calculate_first_piola_kirchoff_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn arruda_boyce_first_piola_kirchoff_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    number_of_links: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        ArrudaBoyceModel::new(
            &[bulk_modulus, shear_modulus, number_of_links]
        ).calculate_first_piola_kirchoff_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn arruda_boyce_helmholtz_free_energy_density(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    number_of_links: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> Scalar {
    ArrudaBoyceModel::new(
        &[bulk_modulus, shear_modulus, number_of_links]
    ).calculate_helmholtz_free_energy_density(
        &DeformationGradient::new(
            std::slice::from_raw_parts(
                deformation_gradient, 9
            )[0]
        )
    )
}

#[no_mangle]
unsafe extern fn gent_cauchy_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extensibility: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        GentModel::new(
            &[bulk_modulus, shear_modulus, extensibility]
        ).calculate_cauchy_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn gent_cauchy_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extensibility: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        GentModel::new(
            &[bulk_modulus, shear_modulus, extensibility]
        ).calculate_cauchy_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn gent_first_piola_kirchoff_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extensibility: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        GentModel::new(
            &[bulk_modulus, shear_modulus, extensibility]
        ).calculate_first_piola_kirchoff_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn gent_first_piola_kirchoff_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extensibility: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        GentModel::new(
            &[bulk_modulus, shear_modulus, extensibility]
        ).calculate_first_piola_kirchoff_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn gent_helmholtz_free_energy_density(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extensibility: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> Scalar {
    GentModel::new(
        &[bulk_modulus, shear_modulus, extensibility]
    ).calculate_helmholtz_free_energy_density(
        &DeformationGradient::new(
            std::slice::from_raw_parts(
                deformation_gradient, 9
            )[0]
        )
    )
}

#[no_mangle]
unsafe extern fn mooney_rivlin_cauchy_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extra_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        MooneyRivlinModel::new(
            &[bulk_modulus, shear_modulus, extra_modulus]
        ).calculate_cauchy_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn mooney_rivlin_cauchy_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extra_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        MooneyRivlinModel::new(
            &[bulk_modulus, shear_modulus, extra_modulus]
        ).calculate_cauchy_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn mooney_rivlin_first_piola_kirchoff_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extra_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        MooneyRivlinModel::new(
            &[bulk_modulus, shear_modulus, extra_modulus]
        ).calculate_first_piola_kirchoff_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn mooney_rivlin_first_piola_kirchoff_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extra_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        MooneyRivlinModel::new(
            &[bulk_modulus, shear_modulus, extra_modulus]
        ).calculate_first_piola_kirchoff_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn mooney_rivlin_helmholtz_free_energy_density(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extra_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> Scalar {
    MooneyRivlinModel::new(
        &[bulk_modulus, shear_modulus, extra_modulus]
    ).calculate_helmholtz_free_energy_density(
        &DeformationGradient::new(
            std::slice::from_raw_parts(
                deformation_gradient, 9
            )[0]
        )
    )
}

#[no_mangle]
unsafe extern fn neo_hookean_cauchy_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        NeoHookeanModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_cauchy_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn neo_hookean_cauchy_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        NeoHookeanModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_cauchy_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn neo_hookean_first_piola_kirchoff_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        NeoHookeanModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_first_piola_kirchoff_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn neo_hookean_first_piola_kirchoff_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        NeoHookeanModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_first_piola_kirchoff_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn neo_hookean_helmholtz_free_energy_density(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> Scalar {
    NeoHookeanModel::new(
        &[bulk_modulus, shear_modulus]
    ).calculate_helmholtz_free_energy_density(
        &DeformationGradient::new(
            std::slice::from_raw_parts(
                deformation_gradient, 9
            )[0]
        )
    )
}

#[no_mangle]
unsafe extern fn saint_venant_kirchoff_cauchy_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        SaintVenantKirchoffModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_cauchy_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn saint_venant_kirchoff_cauchy_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        SaintVenantKirchoffModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_cauchy_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn saint_venant_kirchoff_first_piola_kirchoff_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        SaintVenantKirchoffModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_first_piola_kirchoff_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn saint_venant_kirchoff_first_piola_kirchoff_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        SaintVenantKirchoffModel::new(
            &[bulk_modulus, shear_modulus]
        ).calculate_first_piola_kirchoff_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn saint_venant_kirchoff_helmholtz_free_energy_density(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> Scalar {
    SaintVenantKirchoffModel::new(
        &[bulk_modulus, shear_modulus]
    ).calculate_helmholtz_free_energy_density(
        &DeformationGradient::new(
            std::slice::from_raw_parts(
                deformation_gradient, 9
            )[0]
        )
    )
}

#[no_mangle]
unsafe extern fn fung_cauchy_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extra_modulus: Scalar,
    exponent: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        FungModel::new(
            &[bulk_modulus, shear_modulus, extra_modulus, exponent]
        ).calculate_cauchy_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn fung_cauchy_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extra_modulus: Scalar,
    exponent: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        FungModel::new(
            &[bulk_modulus, shear_modulus, extra_modulus, exponent]
        ).calculate_cauchy_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn fung_first_piola_kirchoff_stress(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extra_modulus: Scalar,
    exponent: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[Scalar; 3]; 3] {
    Box::into_raw(Box::new(
        FungModel::new(
            &[bulk_modulus, shear_modulus, extra_modulus, exponent]
        ).calculate_first_piola_kirchoff_stress(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn fung_first_piola_kirchoff_tangent_stiffness(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extra_modulus: Scalar,
    exponent: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> *const [[[[Scalar; 3]; 3]; 3]; 3] {
    Box::into_raw(Box::new(
        FungModel::new(
            &[bulk_modulus, shear_modulus, extra_modulus, exponent]
        ).calculate_first_piola_kirchoff_tangent_stiffness(
            &DeformationGradient::new(
                std::slice::from_raw_parts(
                    deformation_gradient, 9
                )[0]
            )
        ).as_array()
    ))
}

#[no_mangle]
unsafe extern fn fung_helmholtz_free_energy_density(
    bulk_modulus: Scalar,
    shear_modulus: Scalar,
    extra_modulus: Scalar,
    exponent: Scalar,
    deformation_gradient: *const [[Scalar; 3]; 3]
) -> Scalar {
    FungModel::new(
        &[bulk_modulus, shear_modulus, extra_modulus, exponent]
    ).calculate_helmholtz_free_energy_density(
        &DeformationGradient::new(
            std::slice::from_raw_parts(
                deformation_gradient, 9
            )[0]
        )
    )
}
