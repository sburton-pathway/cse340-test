import db from './db.js'

const getAllProjects = async() => {
    try {
        const query = `
            SELECT o.organization_id, o.name AS organization_name, p.project_id, p.project_id, p.title, p.description, p.location, p.start_date, p.end_date
            FROM project p INNER JOIN organization o ON p.organization_id = o.organization_id
        `;

        const result = await db.query(query);

        return result.rows;
    } catch (error) {
        console.error('Error in database query: ', error.message);
        return [];
    }
}

export {getAllProjects}