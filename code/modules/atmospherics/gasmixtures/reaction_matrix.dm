/*
	The compile-time calculated matrix of bitfields that encodes all possible reactions for any
	given set of reaction factors, namely temperature and the number of moles of each gas in a
	given mix. To check what reactions should be performed, a gas should determine its indices
	into the matrix, then find its matrix element and interpret the bitfields as the set of
	reactions to perform.
*/
/datum/reaction_matrix
	var/list/gas_ids // sorted list of gas ids.
	var/list/reaction_procs // sorted list of reaction proc names.
	var/list/possible_reaction_factors // sorted list of factors to consider. currently includes min and max temp plus moles of each kind of gas.

	// list of lists of doubles, with each list corresponding to a reaction in reaction_procs
	// and each element corresponding to a factor in possible_reaction_factors - zero if the reaction does not consider the factor
	var/list/reaction_float_requirements

	// list of sorted lists of doubles. each list corresponds to a factor in possible_reaction_factors, and each float
	// to a threshold value that appears in reaction_float_requirements for that factor.
	// largely a rotation of reaction_float_requirements.
	var/list/binned_reaction_factors

	// a matrix with the same shape as reaction_float_requirements except with the float values replaced by
	// indices into the lists in binned_reaction_factors.
	var/list/reaction_index_requirements

	// list of the lengths of the lists in reaction_index_requirements, representing the shape of the ideal matrix.
	// eg (2,4,3,5,6) would be a 5D matrix with shape 2x4x3x5x6, and a total of 720 elements,
	// each of which would be a list of bitfields with bits representing qualified reactions.
	var/list/ideal_matrix_shape
