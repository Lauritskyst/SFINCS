module sfincs_openacc
   !
   use sfincs_data
   !
   implicit none
   !
contains
   !
   subroutine initialize_openacc()
   !
   !call acc_init( acc_device_nvidia )
   !
   ! Copy arrays to GPU memory
   ! 
   !$omp target enter data &
   !$omp map(to: kcs, kfuv, kcuv, zs, zs0, zsderv, q, q0) &
   !$omp map(to: uv, uv0, zb, zbuv, zbuvmx, zsmax, maxzsm, qmax, vmax, twet) &
   !$omp map(to: zsm, z_volume, z_flags_iref, uv_flags_iref, uv_flags_type) &
   !$omp map(to: uv_flags_dir, mask_adv, index_kcuv2, nmikcuv2, nmbkcuv2, ibkcuv2, zsb) &
   !$omp map(to: zsb0, ibuvdir, uvmean, subgrid_uv_zmin, subgrid_uv_zmax, subgrid_uv_havg) &
   !$omp map(to: subgrid_uv_nrep, subgrid_uv_pwet, subgrid_uv_havg_zmax, subgrid_uv_nrep_zmax) &
   !$omp map(to: subgrid_uv_fnfit, subgrid_uv_navg_w, subgrid_z_zmin,  subgrid_z_zmax, subgrid_z_dep) &
   !$omp map(to: subgrid_z_volmax, z_index_uv_md, z_index_uv_nd, z_index_uv_mu, z_index_uv_nu, uv_index_z_nm) &
   !$omp map(to: uv_index_z_nmu, uv_index_u_nmd, uv_index_u_nmu, uv_index_u_ndm, uv_index_u_num, uv_index_v_ndm) &
   !$omp map(to: uv_index_v_ndmu, uv_index_v_nm, uv_index_v_nmu, nmindsrc, qtsrc, drainage_type, drainage_params) &
   !$omp map(to: z_index_wavemaker, wavemaker_uvmean, wavemaker_nmd, wavemaker_nmu, wavemaker_ndm, wavemaker_num) &
   !$omp map(to: structure_uv_index, structure_parameters, structure_type, structure_length, fwuv, tauwu, tauwv, tauwu0) &
   !$omp map(to: tauwv0, tauwu1, tauwv1, windu, windv, windu0, windv0, windu1, windv1, windmax, patm, patm0, patm1, patmb) &
   !$omp map(to: nmindbnd, prcp0, prcp1, cumprcp, netprcp, prcp, qext, dxminv, dxrinv, dyrinv, dxm2inv, dxr2inv, dyr2inv) &
   !$omp map(to: dxrinvc, dyrinvc, dxm, dxrm, dyrm, cell_area_m2, cell_area, gn2uv, fcorio2d, storage_volume, nuvisc) &
   !$omp map(to: cuv_index_uv, cuv_index_uv1, cuv_index_uv2, x73, gnapp2, qinffield, qinfmap, cuminf, scs_rain, scs_Se) &
   !$omp map(to: scs_P1, scs_F1, scs_S1, rain_T1, ksfield, GA_head, GA_sigma, GA_sigma_max, GA_F) &
   !$omp map(to: GA_Lu, inf_kr, horton_kd, horton_fc, horton_f0, t_zsmax, drainage_status, drainage_fraction_open, drainage_distance) &
   !$omp map(to: subgrid, crsgeo, use_quadtree,min_dt) &
   !$omp map(to: advection, advection_scheme, coriolis, viscosity, friction2d) &
   !$omp map(to: thetasmoothing, theta, wind, patmos, snapwave, wavemaker) &
   !$omp map(to: wiggle_suppression, wiggle_threshold, wiggle_factor) &
   !$omp map(to: wave_enhanced_roughness, h73table) &
   !$omp map(to: precip, use_qext, use_storage_volume) &
   !$omp map(to: store_maximum_waterlevel, store_t_zsmax) &
   !$omp map(to: store_maximum_velocity, store_maximum_flux, store_twet, twet_threshold) &
   !$omp map(to: g, huthresh, advlim, uvlim, slopelim, rhow, fcorio, nuviscfac) &
   !$omp map(to: subgrid_nlevels, dx, dy, btfilter, btrelax, wmtfilter) &
   !$omp map(to: np, npuv, ncuv, nsrcdrn, ndrn, nsrc, nkcuv2,structure_relax) 
   !$omp map(to: nmi_gbp)
   !   
   end subroutine
   ! 
   subroutine finalize_openacc()
   !
   !$omp target exit data &
   !$omp map(from: kcs, kfuv, kcuv, zs, zs0, zsderv, q, q0, uv) &
   !$omp map(from: uv0, zb, zbuv, zbuvmx, zsmax, maxzsm, qmax, vmax, twet) &
   !$omp map(from: zsm, z_volume, z_flags_iref, uv_flags_iref, uv_flags_type, uv_flags_dir) &
   !$omp map(from:mask_adv, index_kcuv2, nmikcuv2, nmbkcuv2, ibkcuv2, zsb, zsb0, ibuvdir, uvmean) &
   !$omp map(from:subgrid_uv_zmin, subgrid_uv_zmax, subgrid_uv_havg, subgrid_uv_nrep, subgrid_uv_pwet) &
   !$omp map(from:subgrid_uv_havg_zmax, subgrid_uv_nrep_zmax, subgrid_uv_fnfit, subgrid_uv_navg_w,subgrid_z_zmin) &
   !$omp map(from:subgrid_z_zmax, subgrid_z_dep, subgrid_z_volmax, z_index_uv_md, z_index_uv_nd, z_index_uv_mu) &
   !$omp map(from:z_index_uv_nu, uv_index_z_nm, uv_index_z_nmu, uv_index_u_nmd, uv_index_u_nmu, uv_index_u_ndm) &
   !$omp map(from:uv_index_u_num, uv_index_v_ndm, uv_index_v_ndmu, uv_index_v_nm, uv_index_v_nmu, nmindsrc, qtsrc) &
   !$omp map(from:drainage_type, drainage_params, z_index_wavemaker, wavemaker_uvmean, wavemaker_nmd, wavemaker_nmu) &
   !$omp map(from:wavemaker_ndm, wavemaker_num, structure_uv_index, structure_parameters, structure_type, structure_length) &
   !$omp map(from:fwuv, tauwu, tauwv, tauwu0, tauwv0, tauwu1, tauwv1, windu, windv, windu0, windv0, windu1, windv1, windmax) &
   !$omp map(from:patm, patm0, patm1, patmb, nmindbnd, prcp0, prcp1, cumprcp, netprcp, prcp, qext, dxminv, dxrinv, dyrinv) &
   !$omp map(from:dxm2inv, dxr2inv, dyr2inv, dxrinvc, dxm, dxrm, dyrm, cell_area_m2, cell_area, gn2uv, fcorio2d, storage_volume) &
   !$omp map(from:nuvisc, cuv_index_uv, cuv_index_uv1, cuv_index_uv2, x73, gnapp2, qinffield, qinfmap, cuminf, scs_rain, scs_Se) &
   !$omp map(from:scs_P1, scs_F1, scs_S1, rain_T1, ksfield, GA_head, GA_sigma, GA_sigma_max, GA_F, GA_Lu) &
   !$omp map(from: inf_kr, horton_kd, horton_fc, horton_f0 ) &
   !$omp map(from: t_zsmax, drainage_status, drainage_fraction_open, drainage_distance) &
   !$omp map(delete: subgrid, crsgeo, use_quadtree) &
   !$omp map(delete: advection, advection_scheme, coriolis, viscosity, friction2d) &
   !$omp map(delete: thetasmoothing, theta, wind, patmos, snapwave, wavemaker) &
   !$omp map(delete: wiggle_suppression, wiggle_threshold, wiggle_factor) &
   !$omp map(delete: wave_enhanced_roughness, h73table) &
   !$omp map(delete: precip, use_qext, use_storage_volume) &
   !$omp map(delete: store_maximum_waterlevel, store_t_zsmax) &
   !$omp map(delete: store_maximum_velocity, store_maximum_flux, store_twet, twet_threshold) &
   !$omp map(delete: g, huthresh, advlim, uvlim, slopelim, rhow, fcorio, nuviscfac) &
   !$omp map(delete: subgrid_nlevels, dx, dy, btfilter, btrelax, wmtfilter) &
   !$omp map(delete: np, npuv, ncuv, nsrcdrn, ndrn, nsrc, nkcuv2) 
   !
   !   
   end subroutine
   !
end module
