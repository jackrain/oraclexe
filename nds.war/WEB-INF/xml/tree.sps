<?xml version="1.0" encoding="UTF-8"?>
<structure version="1" schemafile="tree.dtd" workingxmlfile="tree.xml" templatexmlfile="">
	<template>
		<match overwrittenxslmatch="/"/>
		<children>
			<template>
				<match match="tree"/>
				<children>
					<paragraph>
						<children>
							<template>
								<match match="node"/>
								<children>
									<table dynamic="1">
										<properties border="1"/>
										<children>
											<tableheader>
												<children>
													<tablerow>
														<children>
															<tablecol>
																<children>
																	<text fixtext="name"/>
																</children>
															</tablecol>
															<tablecol>
																<children>
																	<text fixtext="parent"/>
																</children>
															</tablecol>
															<tablecol>
																<children>
																	<text fixtext="label"/>
																</children>
															</tablecol>
															<tablecol>
																<children>
																	<text fixtext="icon"/>
																</children>
															</tablecol>
															<tablecol>
																<children>
																	<text fixtext="url"/>
																</children>
															</tablecol>
															<tablecol>
																<children>
																	<text fixtext="directory"/>
																</children>
															</tablecol>
														</children>
													</tablerow>
												</children>
											</tableheader>
											<tablebody>
												<children>
													<tablerow>
														<children>
															<tablecol>
																<children>
																	<template>
																		<match match="name"/>
																		<children>
																			<xpath allchildren="1"/>
																		</children>
																	</template>
																</children>
															</tablecol>
															<tablecol>
																<children>
																	<template>
																		<match match="parent"/>
																		<children>
																			<xpath allchildren="1"/>
																		</children>
																	</template>
																</children>
															</tablecol>
															<tablecol>
																<children>
																	<template>
																		<match match="label"/>
																		<children>
																			<xpath allchildren="1"/>
																		</children>
																	</template>
																</children>
															</tablecol>
															<tablecol>
																<children>
																	<template>
																		<match match="icon"/>
																		<children>
																			<select ownvalue="1">
																				<properties size="0"/>
																				<selectoption description="树叶" value=" /images/NDS_folder_sub.gif"/>
																				<selectoption description="树枝" value=" /images/NDS_folder_main.gif"/>
																			</select>
																		</children>
																	</template>
																</children>
															</tablecol>
															<tablecol>
																<children>
																	<template>
																		<match match="url"/>
																		<children>
																			<xpath allchildren="1"/>
																		</children>
																	</template>
																</children>
															</tablecol>
															<tablecol>
																<children>
																	<template>
																		<match match="directory"/>
																		<children>
																			<xpath allchildren="1"/>
																		</children>
																	</template>
																</children>
															</tablecol>
														</children>
													</tablerow>
												</children>
											</tablebody>
										</children>
									</table>
								</children>
							</template>
						</children>
					</paragraph>
				</children>
			</template>
			<text/>
			<newline/>
			<newline/>
		</children>
	</template>
	<template>
		<match match="directory"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
</structure>
