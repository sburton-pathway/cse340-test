import db from './db.js'


const getAllCategories = async() => {
    try {
        const query = `
            SELECT category_id, name, description
            FROM category
            ORDER BY name;
        `;

        const result = await db.query(query);

        return result.rows;
    } catch (error) {
        console.error('Error in database query: ', error.message);
        return [];
    }
}

export {getAllCategories}