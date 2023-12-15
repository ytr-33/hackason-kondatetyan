import * as dotenv from 'dotenv'
dotenv.config()
process.env.RECIPE_PROPOSAL_PERCENTAGE_THRESHOLD="20"
process.env.INGREDIENTS_TABLE_NAME = "tbl_ingredients"
process.env.RECIPES_TABLE_NAME = "tbl_recipes"
process.env.OPENAI_API_MODEL = 'gpt-3.5-turbo'

jest.setTimeout(300000)